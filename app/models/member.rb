require 'securerandom'

class Member < ActiveRecord::Base
  has_many :orders
  has_many :accounts
  has_many :payment_addresses, through: :accounts
  has_many :withdraws
  has_many :fund_sources
  has_many :deposits
  has_many :api_tokens
  has_many :favorites
  has_many :bank_details
  has_many :airdrop_files

  has_one :id_document

  has_many :authentications, dependent: :destroy

  scope :enabled, -> { where(disabled: false) }

  delegate :name,       to: :id_document, allow_nil: true
  delegate :full_name,  to: :id_document, allow_nil: true
  delegate :verified?,  to: :id_document, prefix: true, allow_nil: true

  before_validation :sanitize, :generate_sn, :set_referral_id

  validates :sn, presence: true
  validates :display_name, uniqueness: true, allow_blank: true
  validates :email, email: true, uniqueness: true, allow_nil: true
  validates_uniqueness_of :referral_id

  before_create :build_default_id_document
  after_create  :touch_accounts
  after_update :resend_activation
  after_update :sync_update

  has_one_time_password      # to generate the provisioning uri for otp
  enum otp_module: { disable: 0, enable: 1 }
  enum sms_auth: { sms_disable: 0, sms_enable: 1 }

  has_many :activities

  attr_accessor :country_code

  has_many :referrers,
           class_name: 'Member',
           foreign_key: 'sponsor_id',
           primary_key: 'referral_id'

  belongs_to :sponsor,
             class_name: 'Member',
             foreign_key: 'sponsor_id',
             primary_key: 'referral_id'

  has_many :referral_commissions , foreign_key: 'sponsor_id'


  class << self
    def from_auth(auth_hash)
      locate_auth(auth_hash) || locate_email(auth_hash) || create_from_auth(auth_hash)
    end

    def current
      Thread.current[:user]
    end

    def current=(user)
      Thread.current[:user] = user
    end

    def admins
      Figaro.env.admin.split(',')
    end

    def search(field: nil, term: nil)
      result = case field
                 when 'email'
                   where('members.email LIKE ?', "%#{term}%")
                 when 'name'
                   joins(:id_document).where('id_documents.name LIKE ?', "%#{term}%")
                 when 'wallet_address'
                   members = joins(:fund_sources).where('fund_sources.uid' => term)
                   if members.empty?
                     members = joins(:payment_addresses).where('payment_addresses.address' => term)
                   end
                   members
                 else
                   all
               end

      result.order(:id).reverse_order
    end

    private

    def locate_auth(auth_hash)
      Authentication.locate(auth_hash).try(:member)
    end

    def locate_email(auth_hash)
      return nil if auth_hash['info']['email'].blank?
      member = find_by_email(auth_hash['info']['email'])
      return nil unless member
      member.add_auth(auth_hash)
      member
    end

    def create_from_auth(auth_hash)
      new(email:     auth_hash['info']['email'],
          nickname:  auth_hash['info']['nickname'],
          sponsor_id: auth_hash['info']['description'],
          activated: auth_hash['provider'] != 'identity'
      ).tap do |member|
        member.save!
        member.add_auth(auth_hash)
        member.send_activation if auth_hash['provider'] == 'identity'
      end
    end
  end

  def create_auth_for_identity(identity)
    self.authentications.create(provider: 'identity', uid: identity.id)
  end

  def trades
    Trade.where('bid_member_id = ? OR ask_member_id = ?', id, id)
  end

  def active!
    update activated: true
  end

  def update_password(password)
    identity.update password: password, password_confirmation: password
    send_password_changed_notification
  end

  def admin?
    @is_admin ||= self.class.admins.include?(self.email)
  end

  def add_auth(auth_hash)
    authentications.build_auth(auth_hash).save
  end

  def trigger(event, data)
    AMQPQueue.enqueue(:pusher_member, {member_id: id, event: event, data: data})
  end

  def notify(event, data)
    ::Pusher["private-#{sn}"].trigger_async event, data
  end

  def to_s
    "#{name || email} - #{sn}"
  end

  def gravatar
    "//gravatar.com/avatar/" + Digest::MD5.hexdigest(email.strip.downcase) + "?d=retro"
  end

  def initial?
    name? and !name.empty?
  end

  def get_account(currency)
    account = accounts.with_currency(currency.to_sym).first
    if account.nil?
      touch_accounts
      account = accounts.with_currency(currency.to_sym).first
    end

    account
  end
  alias :ac :get_account

  def touch_accounts
    # less = Currency.codes.map(&:to_s) - self.accounts.map(&:currency).map(&:to_s)
    Currency.all.each do |key|
      self.accounts.create!(currency: key.code, balance: 0, locked: 0,priority: key.priority)
    end
  end

  def identity
    authentication = authentications.find_by_provider('identity')
    authentication ? Identity.find(authentication.uid) : nil
  end

  def auth(name)
    authentications.where(provider: name).first
  end

  def auth_with?(name)
    auth(name).present?
  end

  def remove_auth(name)
    identity.destroy if name == 'identity'
    auth(name).destroy
  end

  def send_activation
    Token::Activation.create(member: self)
  end

  def send_password_changed_notification
    MemberMailer.reset_password_done(self.id).deliver
  end

  def as_json(options = {})
    super(options).merge({
                             "name" => self.name,
                             "memo" => self.id

                         })
  end

  def jwt
    JWT.encode({ email: email, exp: (Time.now.to_i + ENV['SESSION_EXPIRE'].to_i.minutes) * 3 }, APIv2::Auth::Utils.jwt_shared_secret_key, 'RS256')
  end

  def level
    self[:level].to_s.inquiry
  end

  def contact_no
    id_document.contact_no
  end

  def contact_no_without_country_code
     return if id_document&.country_code.nil?
     extend CountryCodes
     record = country_specific_code(id_document&.country_code)
     return record.present? ? contact_no.gsub(record[:dial_code], '') : nil
  end

  def country_dial_code
    return '' if id_document&.country_code.nil?
    extend CountryCodes
    country_deatil = country_specific_code(id_document.country_code)
    return  country_deatil.nil? ? '' : country_deatil[:dial_code]
  end

  def set_estimated_price(records = [])
    records = accounts if records.empty?
    market_prices = MarketPrice.where(base_unit: records.map(&:currency))
    unit_prices = market_prices.inject({}) { |hash, obj| hash.merge!(obj.base_unit => obj.btc_unit)}
    balance = locked = 0
    records.each do |account|
      balance += account.balance * unit_prices[account.currency].to_f
      locked += account.locked * unit_prices[account.currency].to_f
    end
    return balance, locked
  end


  private

  def set_referral_id
    self.referral_id and return
    begin
      self.referral_id = (0..9).to_a.sample(8).join
    end while Member.where(:referral_id => self.referral_id).any?
  end

  def sanitize
    self.email.try(:downcase!)
  end

  def generate_sn
    self.sn and return
    begin
      self.sn = "COIN#{ROTP::Base32.random_base32(8).upcase}CHEL"
    end while Member.where(:sn => self.sn).any?
  end

  def build_default_id_document
    build_id_document
    true
  end

  def resend_activation
    self.send_activation if self.email_changed?
  end

  def sync_update
    ::Pusher["private-#{sn}"].trigger_async('members', { type: 'update', id: self.id, attributes: self.changes_attributes_as_json })
  end
end

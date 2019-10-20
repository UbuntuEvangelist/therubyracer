class Token::ResetPassword < ::Token
  attr_accessor :email
  attr_accessor :password
  attr_accessor :password_confirmation

  before_validation :set_member, on: :create

  validates_presence_of :email, on: :create
  validates :password, format: { with: Rails.application.config.PASSWORD_FORMAT , multiline: true} ,presence: true,
                       on: :update,confirmation: true,
                       length: { minimum: 6, maximum: 64 }
  validates :password_confirmation, presence: true,on: :update, length: { minimum: 6, maximum: 64 }

  after_create :send_token

  def confirm!
    super
    member.update_password password
  end

  private

  def set_member
    if member = Member.find_by_email(self.email)
      self.member = member
    end
  end

  def send_token
    TokenMailer.reset_password(member.email, token).deliver
  end
end
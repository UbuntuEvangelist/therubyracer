module CoinAPI
  Error = Class.new(StandardError) # TODO: Rename to Exception.
  ConnectionRefusedError = Class.new(StandardError) # TODO: Remove this.
  #require 'passgen'

  class << self
    #
    # Returns API client for given currency code.
    #
    # @param code [String, Symbol]
    #   The currency code. May be uppercase or lowercase.
    # @return [BaseAPI]
    def [](code)
      currency = Currency.find_by_code(code.to_s.downcase)
      raise Error, "Couldn't find currency with code #{code.inspect}." unless currency

      if currency.try(:api_client).present?
        "CoinAPI::#{currency.api_client.camelize}"
      else
        "CoinAPI::#{code.upcase}"
      end.constantize.new(currency)
    end
  end

  class BaseAPI
    extend Memoist

    #
    # Returns the currency.
    #
    # @return [Currency]
    attr_reader :currency

    #
    # Returns hot wallet address.
    #
    # @return [String]
    delegate :hot_wallet_address, to: :currency

    def initialize(currency)
      @currency = currency
    end

    #
    # Returns hot wallet balance.
    #
    # @abstract Derived API clients must implement it.
    # @return [BigDecimal]
    def load_balance!(currency)
      method_not_implemented
    end

    #
    # TODO: Docs.
    #
    # @abstract Derived API clients must implement it.
    # @return [Array<Hash>]
    def each_deposit
      method_not_implemented
    end

    #
    # TODO: Docs.
    #
    # @abstract Derived API clients must implement it.
    # @return [Array<Hash>]
    def each_deposit!
      method_not_implemented
    end

    #
    # Returns transaction details.
    #
    # TODO: Docs.
    #
    # @param txid [String]
    # @return [Hash]
    #   The deposit details.
    def load_deposit!(txid)
      method_not_implemented
    end

    #
    # Created new address.
    #
    # TODO: Doc.
    #
    def create_address!
      method_not_implemented
    end

    #
    # Creates new withdrawal and returns transaction ID.
    #
    # TODO: Doc.
    #
    # def create_withdrawal!(issuer, recipient, amount, fee)
    def create_withdrawal!(issuer, recipient, amount, options = {})
      method_not_implemented
    end

    # TODO: Doc.
    def inspect_address!(address)
      method_not_implemented
    end

    def convert_to_base_unit!(value)
      x = value.to_d * currency.base_factor
      unless (x % 1).zero?
        raise CoinAPI::Error, "Failed to convert value to base (smallest) unit because it exceeds the maximum precision: "  "#{value.to_d} - #{x.to_d} must be equal to zero."
      end
      x.to_i
    end

    def convert_from_base_unit(value, currency)
      currency = currency.class == Currency ? currency : Currency.find_by_code(currency)
      value.to_d / currency.base_factor
    end

    %i[ load_balance load_deposit create_address create_withdrawal inspect_address ].each do |method|
      class_eval <<-RUBY
        def #{method}(*args, &block)
          silencing_exception { #{method}!(*args, &block) }
        end
      RUBY
    end

    def normalize_address(address)
      case_sensitive? ? address : address.try(:downcase)
    end

    def normalize_txid(txid)
      case_sensitive? ? txid : txid.try(:downcase)
    end

    # IMPORTANT: Be sure to set the correct value!
    def case_sensitive?
      true
    end


    protected

    def silencing_exception
      yield
    rescue => e
      report_exception(e)
      nil
    end
  end
end
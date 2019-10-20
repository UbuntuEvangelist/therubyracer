##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /
#
# frozen_string_literal: true

module Twilio
  module REST
    class Api < Domain
      class V2010 < Version
        class AccountContext < InstanceContext
          class SipList < ListResource
            class DomainContext < InstanceContext
              class AuthTypesList < ListResource
                class AuthTypeRegistrationsList < ListResource
                  ##
                  # Initialize the AuthTypeRegistrationsList
                  # @param [Version] version Version that contains the resource
                  # @param [String] account_sid The SID of the
                  #   [Account](https://www.twilio.com/docs/iam/api/account) that created the
                  #   SipDomain resource.
                  # @param [String] domain_sid The unique string that that we created to identify
                  #   the SipDomain resource.
                  # @return [AuthTypeRegistrationsList] AuthTypeRegistrationsList
                  def initialize(version, account_sid: nil, domain_sid: nil)
                    super(version)

                    # Path Solution
                    @solution = {account_sid: account_sid, domain_sid: domain_sid}

                    # Components
                    @credential_list_mappings = nil
                  end

                  ##
                  # Access the credential_list_mappings
                  # @param [String] sid The Twilio-provided string that uniquely identifies the
                  #   CredentialListMapping resource to fetch.
                  # @return [AuthRegistrationsCredentialListMappingList]
                  # @return [AuthRegistrationsCredentialListMappingContext] if sid was passed.
                  def credential_list_mappings(sid=:unset)
                    raise ArgumentError, 'sid cannot be nil' if sid.nil?

                    if sid != :unset
                      return AuthRegistrationsCredentialListMappingContext.new(
                          @version,
                          @solution[:account_sid],
                          @solution[:domain_sid],
                          sid,
                      )
                    end

                      @credential_list_mappings ||= AuthRegistrationsCredentialListMappingList.new(
                          @version,
                          account_sid: @solution[:account_sid],
                          domain_sid: @solution[:domain_sid],
                      )
                  end

                  ##
                  # Provide a user friendly representation
                  def to_s
                    '#<Twilio.Api.V2010.AuthTypeRegistrationsList>'
                  end
                end

                class AuthTypeRegistrationsPage < Page
                  ##
                  # Initialize the AuthTypeRegistrationsPage
                  # @param [Version] version Version that contains the resource
                  # @param [Response] response Response from the API
                  # @param [Hash] solution Path solution for the resource
                  # @return [AuthTypeRegistrationsPage] AuthTypeRegistrationsPage
                  def initialize(version, response, solution)
                    super(version, response)

                    # Path Solution
                    @solution = solution
                  end

                  ##
                  # Build an instance of AuthTypeRegistrationsInstance
                  # @param [Hash] payload Payload response from the API
                  # @return [AuthTypeRegistrationsInstance] AuthTypeRegistrationsInstance
                  def get_instance(payload)
                    AuthTypeRegistrationsInstance.new(
                        @version,
                        payload,
                        account_sid: @solution[:account_sid],
                        domain_sid: @solution[:domain_sid],
                    )
                  end

                  ##
                  # Provide a user friendly representation
                  def to_s
                    '<Twilio.Api.V2010.AuthTypeRegistrationsPage>'
                  end
                end

                class AuthTypeRegistrationsInstance < InstanceResource
                  ##
                  # Initialize the AuthTypeRegistrationsInstance
                  # @param [Version] version Version that contains the resource
                  # @param [Hash] payload payload that contains response from Twilio
                  # @param [String] account_sid The SID of the
                  #   [Account](https://www.twilio.com/docs/iam/api/account) that created the
                  #   SipDomain resource.
                  # @param [String] domain_sid The unique string that that we created to identify
                  #   the SipDomain resource.
                  # @return [AuthTypeRegistrationsInstance] AuthTypeRegistrationsInstance
                  def initialize(version, payload, account_sid: nil, domain_sid: nil)
                    super(version)
                  end

                  ##
                  # Provide a user friendly representation
                  def to_s
                    "<Twilio.Api.V2010.AuthTypeRegistrationsInstance>"
                  end

                  ##
                  # Provide a detailed, user friendly representation
                  def inspect
                    "<Twilio.Api.V2010.AuthTypeRegistrationsInstance>"
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
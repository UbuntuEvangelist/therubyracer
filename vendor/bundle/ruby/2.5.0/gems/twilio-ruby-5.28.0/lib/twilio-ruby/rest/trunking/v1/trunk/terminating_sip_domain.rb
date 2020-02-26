##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /
#
# frozen_string_literal: true

module Twilio
  module REST
    class Trunking < Domain
      class V1 < Version
        class TrunkContext < InstanceContext
          class TerminatingSipDomainList < ListResource
            ##
            # Initialize the TerminatingSipDomainList
            # @param [Version] version Version that contains the resource
            # @param [String] trunk_sid The SID of the Trunk to which we should route calls
            #   that arrive at the domain. If a `trunk_sid` is present, we ignore all of the
            #   voice URLs present and terminate calls through the specified trunk.
            # @return [TerminatingSipDomainList] TerminatingSipDomainList
            def initialize(version, trunk_sid: nil)
              super(version)

              # Path Solution
              @solution = {trunk_sid: trunk_sid}
              @uri = "/Trunks/#{@solution[:trunk_sid]}/TerminatingSipDomains"
            end

            ##
            # Retrieve a single page of TerminatingSipDomainInstance records from the API.
            # Request is executed immediately.
            # @param [String] sip_domain_sid The SID of the [SIP
            #   Domain](https://www.twilio.com/docs/voice/sip/api/sip-domain-resource) that you
            #   want to associate with the trunk.
            # @return [TerminatingSipDomainInstance] Newly created TerminatingSipDomainInstance
            def create(sip_domain_sid: nil)
              data = Twilio::Values.of({'SipDomainSid' => sip_domain_sid, })

              payload = @version.create(
                  'POST',
                  @uri,
                  data: data
              )

              TerminatingSipDomainInstance.new(@version, payload, trunk_sid: @solution[:trunk_sid], )
            end

            ##
            # Lists TerminatingSipDomainInstance records from the API as a list.
            # Unlike stream(), this operation is eager and will load `limit` records into
            # memory before returning.
            # @param [Integer] limit Upper limit for the number of records to return. stream()
            #    guarantees to never return more than limit.  Default is no limit
            # @param [Integer] page_size Number of records to fetch per request, when
            #    not set will use the default value of 50 records.  If no page_size is defined
            #    but a limit is defined, stream() will attempt to read the limit with the most
            #    efficient page size, i.e. min(limit, 1000)
            # @return [Array] Array of up to limit results
            def list(limit: nil, page_size: nil)
              self.stream(limit: limit, page_size: page_size).entries
            end

            ##
            # Streams TerminatingSipDomainInstance records from the API as an Enumerable.
            # This operation lazily loads records as efficiently as possible until the limit
            # is reached.
            # @param [Integer] limit Upper limit for the number of records to return. stream()
            #    guarantees to never return more than limit. Default is no limit.
            # @param [Integer] page_size Number of records to fetch per request, when
            #    not set will use the default value of 50 records. If no page_size is defined
            #    but a limit is defined, stream() will attempt to read the limit with the most
            #    efficient page size, i.e. min(limit, 1000)
            # @return [Enumerable] Enumerable that will yield up to limit results
            def stream(limit: nil, page_size: nil)
              limits = @version.read_limits(limit, page_size)

              page = self.page(page_size: limits[:page_size], )

              @version.stream(page, limit: limits[:limit], page_limit: limits[:page_limit])
            end

            ##
            # When passed a block, yields TerminatingSipDomainInstance records from the API.
            # This operation lazily loads records as efficiently as possible until the limit
            # is reached.
            def each
              limits = @version.read_limits

              page = self.page(page_size: limits[:page_size], )

              @version.stream(page,
                              limit: limits[:limit],
                              page_limit: limits[:page_limit]).each {|x| yield x}
            end

            ##
            # Retrieve a single page of TerminatingSipDomainInstance records from the API.
            # Request is executed immediately.
            # @param [String] page_token PageToken provided by the API
            # @param [Integer] page_number Page Number, this value is simply for client state
            # @param [Integer] page_size Number of records to return, defaults to 50
            # @return [Page] Page of TerminatingSipDomainInstance
            def page(page_token: :unset, page_number: :unset, page_size: :unset)
              params = Twilio::Values.of({
                  'PageToken' => page_token,
                  'Page' => page_number,
                  'PageSize' => page_size,
              })
              response = @version.page(
                  'GET',
                  @uri,
                  params
              )
              TerminatingSipDomainPage.new(@version, response, @solution)
            end

            ##
            # Retrieve a single page of TerminatingSipDomainInstance records from the API.
            # Request is executed immediately.
            # @param [String] target_url API-generated URL for the requested results page
            # @return [Page] Page of TerminatingSipDomainInstance
            def get_page(target_url)
              response = @version.domain.request(
                  'GET',
                  target_url
              )
              TerminatingSipDomainPage.new(@version, response, @solution)
            end

            ##
            # Provide a user friendly representation
            def to_s
              '#<Twilio.Trunking.V1.TerminatingSipDomainList>'
            end
          end

          class TerminatingSipDomainPage < Page
            ##
            # Initialize the TerminatingSipDomainPage
            # @param [Version] version Version that contains the resource
            # @param [Response] response Response from the API
            # @param [Hash] solution Path solution for the resource
            # @return [TerminatingSipDomainPage] TerminatingSipDomainPage
            def initialize(version, response, solution)
              super(version, response)

              # Path Solution
              @solution = solution
            end

            ##
            # Build an instance of TerminatingSipDomainInstance
            # @param [Hash] payload Payload response from the API
            # @return [TerminatingSipDomainInstance] TerminatingSipDomainInstance
            def get_instance(payload)
              TerminatingSipDomainInstance.new(@version, payload, trunk_sid: @solution[:trunk_sid], )
            end

            ##
            # Provide a user friendly representation
            def to_s
              '<Twilio.Trunking.V1.TerminatingSipDomainPage>'
            end
          end

          class TerminatingSipDomainContext < InstanceContext
            ##
            # Initialize the TerminatingSipDomainContext
            # @param [Version] version Version that contains the resource
            # @param [String] trunk_sid The SID of the Trunk with the TerminatingSipDomain
            #   resource to fetch.
            # @param [String] sid The unique string that we created to identify the
            #   TerminatingSipDomain resource to fetch.
            # @return [TerminatingSipDomainContext] TerminatingSipDomainContext
            def initialize(version, trunk_sid, sid)
              super(version)

              # Path Solution
              @solution = {trunk_sid: trunk_sid, sid: sid, }
              @uri = "/Trunks/#{@solution[:trunk_sid]}/TerminatingSipDomains/#{@solution[:sid]}"
            end

            ##
            # Fetch a TerminatingSipDomainInstance
            # @return [TerminatingSipDomainInstance] Fetched TerminatingSipDomainInstance
            def fetch
              params = Twilio::Values.of({})

              payload = @version.fetch(
                  'GET',
                  @uri,
                  params,
              )

              TerminatingSipDomainInstance.new(
                  @version,
                  payload,
                  trunk_sid: @solution[:trunk_sid],
                  sid: @solution[:sid],
              )
            end

            ##
            # Deletes the TerminatingSipDomainInstance
            # @return [Boolean] true if delete succeeds, false otherwise
            def delete
              @version.delete('delete', @uri)
            end

            ##
            # Provide a user friendly representation
            def to_s
              context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
              "#<Twilio.Trunking.V1.TerminatingSipDomainContext #{context}>"
            end

            ##
            # Provide a detailed, user friendly representation
            def inspect
              context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
              "#<Twilio.Trunking.V1.TerminatingSipDomainContext #{context}>"
            end
          end

          class TerminatingSipDomainInstance < InstanceResource
            ##
            # Initialize the TerminatingSipDomainInstance
            # @param [Version] version Version that contains the resource
            # @param [Hash] payload payload that contains response from Twilio
            # @param [String] trunk_sid The SID of the Trunk to which we should route calls
            #   that arrive at the domain. If a `trunk_sid` is present, we ignore all of the
            #   voice URLs present and terminate calls through the specified trunk.
            # @param [String] sid The unique string that we created to identify the
            #   TerminatingSipDomain resource to fetch.
            # @return [TerminatingSipDomainInstance] TerminatingSipDomainInstance
            def initialize(version, payload, trunk_sid: nil, sid: nil)
              super(version)

              # Marshaled Properties
              @properties = {
                  'account_sid' => payload['account_sid'],
                  'api_version' => payload['api_version'],
                  'auth_type' => payload['auth_type'],
                  'date_created' => Twilio.deserialize_iso8601_datetime(payload['date_created']),
                  'date_updated' => Twilio.deserialize_iso8601_datetime(payload['date_updated']),
                  'domain_name' => payload['domain_name'],
                  'friendly_name' => payload['friendly_name'],
                  'sid' => payload['sid'],
                  'url' => payload['url'],
                  'voice_fallback_method' => payload['voice_fallback_method'],
                  'voice_fallback_url' => payload['voice_fallback_url'],
                  'voice_method' => payload['voice_method'],
                  'voice_status_callback_method' => payload['voice_status_callback_method'],
                  'voice_status_callback_url' => payload['voice_status_callback_url'],
                  'voice_url' => payload['voice_url'],
                  'sip_registration' => payload['sip_registration'],
                  'trunk_sid' => payload['trunk_sid'],
                  'links' => payload['links'],
              }

              # Context
              @instance_context = nil
              @params = {'trunk_sid' => trunk_sid, 'sid' => sid || @properties['sid'], }
            end

            ##
            # Generate an instance context for the instance, the context is capable of
            # performing various actions.  All instance actions are proxied to the context
            # @return [TerminatingSipDomainContext] TerminatingSipDomainContext for this TerminatingSipDomainInstance
            def context
              unless @instance_context
                @instance_context = TerminatingSipDomainContext.new(@version, @params['trunk_sid'], @params['sid'], )
              end
              @instance_context
            end

            ##
            # @return [String] The SID of the Account that created the resource
            def account_sid
              @properties['account_sid']
            end

            ##
            # @return [String] The API version used to process the call
            def api_version
              @properties['api_version']
            end

            ##
            # @return [String] The types of authentication mapped to the domain
            def auth_type
              @properties['auth_type']
            end

            ##
            # @return [Time] The RFC 2822 date and time in GMT when the resource was created
            def date_created
              @properties['date_created']
            end

            ##
            # @return [Time] The RFC 2822 date and time in GMT when the resource was last updated
            def date_updated
              @properties['date_updated']
            end

            ##
            # @return [String] The unique address you reserve on Twilio to which you route your SIP traffic
            def domain_name
              @properties['domain_name']
            end

            ##
            # @return [String] The string that you assigned to describe the resource
            def friendly_name
              @properties['friendly_name']
            end

            ##
            # @return [String] The unique string that identifies the resource
            def sid
              @properties['sid']
            end

            ##
            # @return [String] The absolute URL of the resource
            def url
              @properties['url']
            end

            ##
            # @return [String] The HTTP method used with voice_fallback_url
            def voice_fallback_method
              @properties['voice_fallback_method']
            end

            ##
            # @return [String] The URL that we call when an error occurs in executing TwiML
            def voice_fallback_url
              @properties['voice_fallback_url']
            end

            ##
            # @return [String] The HTTP method used with voice_url
            def voice_method
              @properties['voice_method']
            end

            ##
            # @return [String] The HTTP method that we use to call the voice_status_callback_url
            def voice_status_callback_method
              @properties['voice_status_callback_method']
            end

            ##
            # @return [String] The URL that we call to pass status parameters to your application
            def voice_status_callback_url
              @properties['voice_status_callback_url']
            end

            ##
            # @return [String] The URL we call when the domain receives a call
            def voice_url
              @properties['voice_url']
            end

            ##
            # @return [Boolean] Whether SIP Endpoints can register with the domain to receive calls
            def sip_registration
              @properties['sip_registration']
            end

            ##
            # @return [String] The SID of the Trunk to which we should route calls
            def trunk_sid
              @properties['trunk_sid']
            end

            ##
            # @return [String] The URLs of related resources
            def links
              @properties['links']
            end

            ##
            # Fetch a TerminatingSipDomainInstance
            # @return [TerminatingSipDomainInstance] Fetched TerminatingSipDomainInstance
            def fetch
              context.fetch
            end

            ##
            # Deletes the TerminatingSipDomainInstance
            # @return [Boolean] true if delete succeeds, false otherwise
            def delete
              context.delete
            end

            ##
            # Provide a user friendly representation
            def to_s
              values = @params.map{|k, v| "#{k}: #{v}"}.join(" ")
              "<Twilio.Trunking.V1.TerminatingSipDomainInstance #{values}>"
            end

            ##
            # Provide a detailed, user friendly representation
            def inspect
              values = @properties.map{|k, v| "#{k}: #{v}"}.join(" ")
              "<Twilio.Trunking.V1.TerminatingSipDomainInstance #{values}>"
            end
          end
        end
      end
    end
  end
end
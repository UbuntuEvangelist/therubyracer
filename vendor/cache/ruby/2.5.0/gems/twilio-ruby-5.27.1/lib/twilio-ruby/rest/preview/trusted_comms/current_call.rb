##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /
#
# frozen_string_literal: true

module Twilio
  module REST
    class Preview < Domain
      class TrustedComms < Version
        ##
        # PLEASE NOTE that this class contains preview products that are subject to change. Use them with caution. If you currently do not have developer preview access, please contact help@twilio.com.
        class CurrentCallList < ListResource
          ##
          # Initialize the CurrentCallList
          # @param [Version] version Version that contains the resource
          # @return [CurrentCallList] CurrentCallList
          def initialize(version)
            super(version)

            # Path Solution
            @solution = {}
          end

          ##
          # Provide a user friendly representation
          def to_s
            '#<Twilio.Preview.TrustedComms.CurrentCallList>'
          end
        end

        ##
        # PLEASE NOTE that this class contains preview products that are subject to change. Use them with caution. If you currently do not have developer preview access, please contact help@twilio.com.
        class CurrentCallPage < Page
          ##
          # Initialize the CurrentCallPage
          # @param [Version] version Version that contains the resource
          # @param [Response] response Response from the API
          # @param [Hash] solution Path solution for the resource
          # @return [CurrentCallPage] CurrentCallPage
          def initialize(version, response, solution)
            super(version, response)

            # Path Solution
            @solution = solution
          end

          ##
          # Build an instance of CurrentCallInstance
          # @param [Hash] payload Payload response from the API
          # @return [CurrentCallInstance] CurrentCallInstance
          def get_instance(payload)
            CurrentCallInstance.new(@version, payload, )
          end

          ##
          # Provide a user friendly representation
          def to_s
            '<Twilio.Preview.TrustedComms.CurrentCallPage>'
          end
        end

        ##
        # PLEASE NOTE that this class contains preview products that are subject to change. Use them with caution. If you currently do not have developer preview access, please contact help@twilio.com.
        class CurrentCallContext < InstanceContext
          ##
          # Initialize the CurrentCallContext
          # @param [Version] version Version that contains the resource
          # @return [CurrentCallContext] CurrentCallContext
          def initialize(version)
            super(version)

            # Path Solution
            @solution = {}
            @uri = "/CurrentCall"
          end

          ##
          # Fetch a CurrentCallInstance
          # @return [CurrentCallInstance] Fetched CurrentCallInstance
          def fetch
            params = Twilio::Values.of({})

            payload = @version.fetch(
                'GET',
                @uri,
                params,
            )

            CurrentCallInstance.new(@version, payload, )
          end

          ##
          # Provide a user friendly representation
          def to_s
            context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
            "#<Twilio.Preview.TrustedComms.CurrentCallContext #{context}>"
          end

          ##
          # Provide a detailed, user friendly representation
          def inspect
            context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
            "#<Twilio.Preview.TrustedComms.CurrentCallContext #{context}>"
          end
        end

        ##
        # PLEASE NOTE that this class contains preview products that are subject to change. Use them with caution. If you currently do not have developer preview access, please contact help@twilio.com.
        class CurrentCallInstance < InstanceResource
          ##
          # Initialize the CurrentCallInstance
          # @param [Version] version Version that contains the resource
          # @param [Hash] payload payload that contains response from Twilio
          # @return [CurrentCallInstance] CurrentCallInstance
          def initialize(version, payload)
            super(version)

            # Marshaled Properties
            @properties = {
                'sid' => payload['sid'],
                'from' => payload['from'],
                'to' => payload['to'],
                'status' => payload['status'],
                'reason' => payload['reason'],
                'created_at' => Twilio.deserialize_iso8601_datetime(payload['created_at']),
                'caller' => payload['caller'],
                'logo' => payload['logo'],
                'bg_color' => payload['bg_color'],
                'font_color' => payload['font_color'],
                'use_case' => payload['use_case'],
                'manager' => payload['manager'],
                'shield_img' => payload['shield_img'],
                'url' => payload['url'],
            }

            # Context
            @instance_context = nil
            @params = {}
          end

          ##
          # Generate an instance context for the instance, the context is capable of
          # performing various actions.  All instance actions are proxied to the context
          # @return [CurrentCallContext] CurrentCallContext for this CurrentCallInstance
          def context
            unless @instance_context
              @instance_context = CurrentCallContext.new(@version, )
            end
            @instance_context
          end

          ##
          # @return [String] A string that uniquely identifies this current phone call.
          def sid
            @properties['sid']
          end

          ##
          # @return [String] The originating phone number
          def from
            @properties['from']
          end

          ##
          # @return [String] The terminating phone number
          def to
            @properties['to']
          end

          ##
          # @return [String] The status of the current phone call
          def status
            @properties['status']
          end

          ##
          # @return [String] The business reason for this current phone call
          def reason
            @properties['reason']
          end

          ##
          # @return [Time] The date this current phone call was created
          def created_at
            @properties['created_at']
          end

          ##
          # @return [String] Caller name of the current phone call
          def caller
            @properties['caller']
          end

          ##
          # @return [String] Logo URL of the caller
          def logo
            @properties['logo']
          end

          ##
          # @return [String] Background color of the current phone call
          def bg_color
            @properties['bg_color']
          end

          ##
          # @return [String] Font color of the current phone call
          def font_color
            @properties['font_color']
          end

          ##
          # @return [String] The use case for the current phone call
          def use_case
            @properties['use_case']
          end

          ##
          # @return [String] The name of the CPS organization
          def manager
            @properties['manager']
          end

          ##
          # @return [String] Shield image URL that serves as authenticity proof of the current phone call
          def shield_img
            @properties['shield_img']
          end

          ##
          # @return [String] The URL of this resource.
          def url
            @properties['url']
          end

          ##
          # Fetch a CurrentCallInstance
          # @return [CurrentCallInstance] Fetched CurrentCallInstance
          def fetch
            context.fetch
          end

          ##
          # Provide a user friendly representation
          def to_s
            values = @params.map{|k, v| "#{k}: #{v}"}.join(" ")
            "<Twilio.Preview.TrustedComms.CurrentCallInstance #{values}>"
          end

          ##
          # Provide a detailed, user friendly representation
          def inspect
            values = @properties.map{|k, v| "#{k}: #{v}"}.join(" ")
            "<Twilio.Preview.TrustedComms.CurrentCallInstance #{values}>"
          end
        end
      end
    end
  end
end
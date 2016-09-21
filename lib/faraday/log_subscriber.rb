require 'active_support/notifications'
require 'logstasher/custom_fields'

module LogStasher
  module Faraday
    class LogSubscriber < ActiveSupport::LogSubscriber
      include CustomFields::LogSubscriber

      def logger
        LogStasher.logger
      end

      def self.runtime=(value)
        Thread.current['faraday_runtime'] = value
      end

      def self.runtime
        Thread.current['faraday_runtime'] ||= 0
      end

      def self.reset_runtime
        rt, self.runtime = runtime, 0
        rt
      end

      def http_cache(event)
        data = event.payload

        data.merge! request_context
        data.merge! LogStasher.store

        tags = []
        logger << LogStasher.build_logstash_event(data, tags).to_json + "\n"
      end

      def request(event)
        self.class.runtime += event.duration
        env = event.payload

        url = env[:url]
        http_method = env[:method].to_s.upcase

        data = {
          name: 'request.faraday',
          host: url.host,
          method: http_method,
          request_uri: url.request_uri,
          status: env.status,
          duration: event.duration.round(2)
        }

        data.merge! request_context
        data.merge! LogStasher.store

        tags = []
        tags.push('unsuccessful') unless env.success?

        logger << LogStasher.build_logstash_event(data, tags).to_json + "\n"
      end

      attach_to :faraday

      private

      def request_context
        LogStasher.request_context
      end

      def store
        LogStasher.store
      end
    end
  end
end

require "savon"

module CDP
  module Drivers
    class Savon < Base
      class << self
        def log(log)
          ::Savon.log = log
        end

        def logger(logger)
          ::Savon.logger = logger
        end

        def log_level(level)
          ::Savon.log_level = log_level
        end
      end

      attr_reader :api

      def initialize(service, options = {})
        super

        @api = ::Savon::Client.new do |wsdl, http|
          wsdl.document = url
          http.auth.basic(user, password) if user && password
        end
      end

      def call(method, args = {})
        begin
          api.request(method, args)
        rescue ::Savon::Error => e
          raise CDPError.new(e)
        end
      end
    end
  end
end
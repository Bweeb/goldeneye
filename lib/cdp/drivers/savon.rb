require "savon"

module CDP
  module Drivers
    class Savon < Base
      attr_reader :api

      def initialize(service, options = {})
        super

        ::Savon.configure do |config|
          config.soap_version = 1  # use SOAP 1.2
        end

        @api = ::Savon::Client.new do |wsdl, http|
          wsdl.document = url
          http.auth.basic(user, password) if user && password
        end
      end

      def call(method, args = {})
        begin
          api.request(method) do |soap|
            soap.body = args
          end.to_hash["#{method}_response".to_sym]
        rescue ::Savon::Error => e
          raise CDPError.new(e)
        end
      end
    end
  end
end
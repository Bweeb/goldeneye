require "savon"

module Goldeneye
  module Drivers
    class Savon < Base
      class << self
        def log=(log)
          ::Savon.log = log
          ::HTTPI.log = log
        end
      end

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
            # Manually uses Gyoku to generate the body xml becase by default Savon appends the
            # namespace to the parameters and that does not work with the R1 CDP api
            soap.body = Gyoku.xml(args)
          end.to_xml
        rescue ::Savon::Error => e
          raise Error.new(e)
        end
      end
    end
  end
end
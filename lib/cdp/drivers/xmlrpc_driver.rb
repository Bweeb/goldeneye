module CDP
  module Drivers
    class XMLRPC < Base

      attr_reader :api

      def initialize(options = {})
        super
        @api = ::XMLRPC::Client.new(host, path, port, proxy_host, proxy_port, user, password, use_ssl, timeout)

        # hack to disable ssl certificate check
        @api.instance_variable_get(:@http).instance_variable_set(:@verify_mode, OpenSSL::SSL::VERIFY_NONE)
      end

      def call(method, *args)
        begin
          api.call(method, *args)
        rescue ::XMLRPC::FaultException, SocketError => e
          raise CDPError.new(e)
        end
      end
    end
  end
end
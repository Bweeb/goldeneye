module CDP
  module Drivers
    class Base

      attr_reader :host, :path, :port, :proxy_host, :proxy_port, :user, :password, :use_ssl, :timeout

      def initialize(options = {})
        @host       = options[:host] || CDP.host
        @path       = options[:path] || CDP.path || "xmlrpc"
        @port       = options[:port] || CDP.port || 8084
        @proxy_host = options[:proxy_host] || CDP.proxy_host
        @proxy_port = options[:proxy_port] || CDP.proxy_port
        @user       = options[:user] || CDP.user
        @password   = options[:password] || CDP.password
        @use_ssl    = options[:use_ssl] || CDP.use_ssl
        @timeout    = options[:timeout] || CDP.timeout
      end

      def call(method, *args)
        raise NotImplementedError
      end
    end
  end
end
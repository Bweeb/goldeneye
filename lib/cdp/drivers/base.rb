module CDP
  module Drivers
    class Base

      attr_accessor :url, :user, :password, :logger

      def initialize(service, options = {})
        @url      = "#{(options[:url] || CDP.url)}/#{service}?wsdl"
        @user     = options[:user] || CDP.user
        @password = options[:password] || CDP.password
        @logger   = options[:logger] || CDP.logger
      end

      def call(method, *args)
        raise NotImplementedError
      end
    end
  end
end
module CDP
  module Drivers
    class Base

      attr_accessor :url, :user, :password, :logger, :driver

      def initialize(options = {})
        @url      = options[:url] || CDP.url
        @user     = options[:user] || CDP.user
        @password = options[:password] || CDP.password
        @logger   = options[:logger] || CDP.logger
        @driver   = options[:driver] || CDP.driver || Savon
      end

      def call(method, *args)
        raise NotImplementedError
      end
    end
  end
end
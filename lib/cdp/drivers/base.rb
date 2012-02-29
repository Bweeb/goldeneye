module CDP
  module Drivers
    class Base
      attr_accessor :url, :user, :password

      def initialize(service, options = {})
        @url      = "#{(options[:url] || CDP.url)}/#{service}?wsdl"
        @user     = options[:user] || CDP.user
        @password = options[:password] || CDP.password
      end

      def call(method, *args)
        raise NotImplementedError
      end
    end
  end
end
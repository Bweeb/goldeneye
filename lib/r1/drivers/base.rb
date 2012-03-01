module R1
  module Drivers
    class Base
      attr_accessor :url, :user, :password

      def initialize(service, options = {})
        @url      = "#{(options[:url]  || R1.url)}/#{service}?wsdl"
        @user     = options[:user]     || R1.user
        @password = options[:password] || R1.password
      end

      def call(method, args = {})
        raise NotImplementedError
      end
    end
  end
end
module Goldeneye
  module Drivers
    class Base
      class << self
        # Defines if this class will log its interactions
        def log=(log)
          raise NotImplementedError
        end
      end

      attr_accessor :url, :user, :password

      def initialize(service, options = {})
        @url      = "#{(options[:url]  || Goldeneye.url)}/#{service}?wsdl"
        @user     = options[:user]     || Goldeneye.user
        @password = options[:password] || Goldeneye.password
      end

      def call(method, args = {})
        raise NotImplementedError
      end
    end
  end
end
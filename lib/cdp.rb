require "rubygems"
require "cdp/exceptions"
require "cdp/base"
require "cdp/drivers/base"
require "cdp/drivers/savon"

module CDP
  class << self
    attr_accessor :url, :user, :password
    attr_reader :driver

    def driver
      Drivers::Savon
    end

    # Configures base data for making requests.
    #
    # Example:
    #
    #   CDP.config(
    #     :url        => configuration[:url],
    #     :user       => configuration[:user],
    #     :password   => configuration[:password]
    #   )
    def config(options = {})
      @url      = options[:url]
      @user     = options[:user]
      @password = options[:password]
    end
  end
end

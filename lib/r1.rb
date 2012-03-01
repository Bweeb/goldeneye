require "rubygems"
require "xmlsimple"
require "r1/exceptions"
require "r1/base"
require "r1/drivers/base"
require "r1/drivers/savon"

module R1
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
    #   R1.config(
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

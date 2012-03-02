require "rubygems"
require "logging"
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

    # Gets or sets the logger.
    # Log level can be set like this:
    #
    #    R1.logger.level = :info
    def logger(output = nil)
      if output
        @logger = Logging.logger(output)
      end

      @logger ||= Logging.logger(STDOUT)
    end
  end
end

require "r1/services/cdp"
require "r1/services/disk_safe"
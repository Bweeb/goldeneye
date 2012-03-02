require "rubygems"
require "logging"
require "xmlsimple"
require "goldeneye/exceptions"
require "goldeneye/base"
require "goldeneye/drivers/base"
require "goldeneye/drivers/savon"

module Goldeneye
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
    #   Goldeneye.config(
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
    #    Goldeneye.logger.level = :info
    def logger(output = nil)
      if output
        @logger = Logging.logger(output)
      end

      @logger ||= Logging.logger(STDOUT)
    end
  end
end

require "goldeneye/services/cdp"
require "goldeneye/services/storage_disk"
require "goldeneye/services/disk_safe"
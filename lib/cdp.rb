require "rubygems"
require "logging"

module CDP
  class << self
    attr_accessor :host, :path, :port, :proxy_host, :proxy_port, :user, :password, :use_ssl, :timeout

    # Configures base data for making requests.
    #
    # Example:
    #
    #   CDP.config(
    #     :logger     => mylogger,
    #     :host       => configuration[:host],
    #     :path       => configuration[:path],
    #     :port       => configuration[:port],
    #     :proxy_host => configuration[:proxy_host],
    #     :proxy_port => configuration[:proxy_port],
    #     :user       => configuration[:user],
    #     :password   => configuration[:password],
    #     :use_ssl    => configuration[:use_ssl],
    #     :timeout    => configuration[:timeout]
    #   )
    def config(options = {})
      logger(options.delete(:logger))

      options.each do |key, value|
        send("#{key}=", value) if respond_to?("#{key}=")
      end
    end

    def logger(logger = nil)
      if logger
        @logger = Logging.logger(logger)
      end

      @logger ||= Logging.logger(STDOUT)
    end
  end
end

require 'cdp/exceptions'
require 'cdp/base'
require 'cdp/server'
require 'cdp/drivers/base_driver'
require 'cdp/drivers/xmlrpc_driver'
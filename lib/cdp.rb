require 'rubygems'

module CDP
  class << self
    attr_accessor :host, :path, :port, :proxy_host, :user, :password, :use_ssl, :timeout

    # Configures base data for making requests.
    #
    # Example:
    #
    #   CDP.config do |c|
    #     c.host       = configuration[:host]
    #     c.path       = configuration[:path]
    #     c.port       = configuration[:port]
    #     c.proxy_host = configuration[:proxy_host]
    #     c.user       = configuration[:user]
    #     c.password   = configuration[:password]
    #     c.use_ssl    = configuration[:use_ssl]
    #     c.timeout    = configuration[:timeout]
    #   end
    def config
      yield(self)
    end
  end
end

require 'cdp/exceptions'
require 'cdp/base'
require 'cdp/server'

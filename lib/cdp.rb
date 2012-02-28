require 'rubygems'

module CDP
  class << self
    attr_accessor :api_endpoint, :api_id, :api_key, :api_options

    # Specifies the login and url for making requests
    #
    # example:
    #
    #   Solusvm.config('id', 'key', :url => 'http://www.example.com/api', :logger => RAILS_LOGGER, :logger_method => :log_info)
    #
    # Options:
    # * <tt>:logger</tt> - Log object used for logging API responses
    # * <tt>:logger_method</tt> - The method that performs the logging on the Log object
    def config(api_id, api_key, options={})
      @api_id       = api_id
      @api_key      = api_key
      @api_endpoint = URI.parse(options.delete(:url))
      @api_options  = options
    end
  end
end

require 'cdp/exceptions'
require 'cdp/hash'
require 'cdp/base'
require 'cdp/general'

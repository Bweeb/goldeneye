require "xmlrpc/client"

module CDP
  # CDP::Base is the main class for mapping API resources as subclasses.
  class Base

    attr_accessor :logger, :host, :path, :port, :proxy_host, :user, :password, :use_ssl, :timeout
    attr_reader   :api

    # Initializes the api using CDP default options or the received options.
    # This accept the same options as CDP.config.
    def initialize(options = {})
      self.host       = CDP.host
      self.path       = CDP.path || "xmlrpc"
      self.port       = CDP.port || 8084
      self.proxy_host = CDP.proxy_host
      self.user       = CDP.user
      self.password   = CDP.password
      self.use_ssl    = CDP.use_ssl
      self.timeout    = CDP.timeout

      options.each do |key, value|
        send("#{key}=", value) if respond_to?("#{key}=")
      end

      @api = XMLRPC::Client.new(host, path, port, proxy_host, user, password, use_ssl, timeout)
    end

    # Prepares and sends the API request to the configured server.
    #
    #  class MyClass < Base
    #    def create_server(name)
    #      perform_request("the.method", arg1, arg2, ...)
    #    end
    #  end
    #
    # The method returns the return-value from the RPC. Available return types can be seen here:
    # http://www.ntecs.de/ruby/xmlrpc4r/client.html
    #
    # If the remote procedure returned a fault-structure, then a CDP::CDPError exception
    # is raised.
    def perform_request(method, *args)
      begin
        CDP.logger.debug("[Start] => #{method} : #{args.to_s}")
        result = api.call(method, *args)
        CDP.logger.debug("[End] => #{method} : #{result.to_s}")
        result
      rescue XMLRPC::FaultException => e
        raise CDPError.new(e)
      end
    end
  end
end

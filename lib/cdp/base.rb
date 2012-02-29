require "xmlrpc/client"

module CDP
  # CDP::Base is the main class for mapping API resources as subclasses.
  class Base

    attr_reader :driver

    # Initializes the api using CDP default options or the received options.
    # This accept the same options as CDP.config.
    def initialize(options = {})
      options[:service] = service

      @driver = (CDP.driver || Drivers::Savon).new(options)
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
      driver.call(method, *args)
    end

    # Services classes should implement this class with the proper CDP service name.
    def service
      raise NotImplementedError
    end
  end
end

module R1
  class CDP < Base

    # Retrieve a list of Data Center Console (DCC) registered CDP Servers.
    def get_registered_cdps
      perform_request("getRegisteredCDPS", {}, "return")
    end

  end
end
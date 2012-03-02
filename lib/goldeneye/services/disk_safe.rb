module Goldeneye
  class DiskSafe < Base

    # Retrieve a list of Data Center Console (DCC) registered CDP Servers.
    def get_disk_safes
      perform_request("getDiskSafes", {}, ["return", "deviceList"]) || []
    end

  end
end
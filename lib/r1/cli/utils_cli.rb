module R1
  class UtilsCli < BaseCli

    ONE_GB = 1073741824.0

    desc "list_cdps_devices", "Lists CDPs devices and its memory information"
    def list_cdps_devices
      cdps = cdp_api.get_registered_cdps.sort{|cdp1, cdp2| cdp1["name"] <=> cdp2["name"]}.uniq

      cdps.each do |cdp|
        output "CDP #{cdp["name"]}:"

        disk_safes = DiskSafe.new(:url => "http://#{cdp["ipHost"]}:#{cdp["apiPort"]}").
                              get_disk_safes.sort{|ds1, ds2| ds1["description"] <=> ds2["description"]}.
                              uniq

        disk_safes.each do |disk_safe|
          output "  DiskSafe #{disk_safe["description"]}:"
          disk_safe["deviceList"].sort{|dev1, dev2| dev1["devicePath"] <=> dev2["devicePath"]}.each do |device|
            free_space = (device["totalBlocks"].to_i - device["allocatedBlocks"].to_i) * device["blockSize"].to_i
            free_space = (free_space / ONE_GB).round(1)
            output "    #{device["devicePath"]}: #{free_space} GB"
          end
        end
      end
    end

    private

    def cdp_api
      @cdp_api ||= begin
        configure
        CDP.new
      end
    end
  end
end
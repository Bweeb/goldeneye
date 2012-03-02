module R1
  class UtilsCli < BaseCli

    ONE_GB = 1073741824.0

    desc "list_cdps_devices", "Lists CDPs devices and its memory information; This should be called
                              under the main CDP server."
    def list_cdps_devices
      cdps = []

      cdp_api.get_registered_cdps.each do |cdp|
        unless cdps.include?(cdp)
          output "CDP #{cdp["name"]}:"

          DiskSafe.new(:url => "http://#{cdp["ipHost"]}:#{cdp["apiPort"]}").get_disk_safes.each do |disk_safe|
            disk_safe["deviceList"].each do |device|
              free_space = (device["totalBlocks"].to_i - device["allocatedBlocks"].to_i) * device["blockSize"].to_i
              free_space = (free_space / ONE_GB).round(1)
              output "    #{device["devicePath"]}: #{free_space} GB"
            end
          end

          cdps << cdp
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
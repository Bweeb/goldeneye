module R1
  class UtilsCli < BaseCli

    ONE_GB = 1073741824.0

    desc "list_cdps_devices", "Lists existing nodes for a given type [openvz|xen|xen hvm|kvm]"
    def list_cdps_devices
      cdps_disk_safes = []
      cdps            = cdp.get_registered_cdps

      cdps.each do |cdp|
        cdp_url = "http://#{cdp["ipHost"]}:#{cdp["apiPort"]}"
        cdps_disk_safes << {:cdp => cdp, :disk_safes => DiskSafe.new(:url => cdp_url).get_disk_safes}
      end

      messages = []

      cdps_disk_safes.each do |cdp|
        messages << "CDP #{cdp[:cdp]["name"]}:"
        if cdp[:disk_safes]
          cdp[:disk_safes].each do |disk_safe|
            disk_safe["deviceList"].each do |device|
              free_space = (device["totalBlocks"].to_i - device["allocatedBlocks"].to_i) * device["blockSize"].to_i
              free_space = (free_space / ONE_GB).round(1)
              messages << "    #{device["devicePath"]}: #{free_space} GB"
            end
          end
        end
      end

      output(messages)
    end

    private

    def cdp
      @cdp ||= begin
        configure
        CDP.new
      end
    end
  end
end
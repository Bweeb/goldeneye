module Goldeneye
  class UtilsCli < BaseCli

    ONE_GB = 1073741824.0

    desc "storage_disks", "Lists storage disks and its memory information"
    def storage_disks
      cdps = cdp_api.get_registered_cdps.sort{|cdp1, cdp2| cdp1["name"] <=> cdp2["name"]}.uniq

      cdps.each do |cdp|
        output "CDP #{cdp["name"]}:"

        storage_disk_api = StorageDisk.new(:url => "http://#{cdp["ipHost"]}:#{cdp["apiPort"]}")
        storage_disk_api.get_storage_disk_paths.delete_if{|path| path.nil? || path == "none"}.each do |path|
          disk = storage_disk_api.get_storage_disk_by_path(path)

          output "  #{path}:"
          output "    Capacity: #{disk["capacityBytes"]}"
          output "    Free: #{disk["freeBytes"]}"
          output "    Usage: #{disk["usageBytes"]}"
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
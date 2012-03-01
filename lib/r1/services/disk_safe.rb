module R1
  class DiskSafe < Base

    # Returns the list of all disk safe UUIDs the user has access to.
    def get_disk_safe_ids
      perform_request("getDiskSafeIDs", {}, "return")
    end

    # Get devices for a specified disk safe.
    def get_stored_devices_for_disk_safe(id)
      perform_request("getStoredDevicesForDiskSafe", {"diskSafe" => {"id" => id}}, "return")
    end

  end
end
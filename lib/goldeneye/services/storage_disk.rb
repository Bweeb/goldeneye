module Goldeneye
  class StorageDisk < Base

    def get_storage_disk_paths
      perform_request("getStorageDiskPaths", {}, "return") || []
    end

    def get_storage_disk_by_path(path)
      perform_request("getStorageDiskByPath", {"storageDiskPath" => path})
    end

  end
end
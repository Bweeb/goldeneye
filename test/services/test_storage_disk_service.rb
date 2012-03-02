require 'helper'

class TestStorageDiskService < Test::Unit::TestCase

  def setup
    @service = Goldeneye::StorageDisk.new
  end

  def test_get_storage_disk_paths
    @service.expects(:perform_request).with("getStorageDiskPaths", {}, "return").returns(:response)
    assert_equal :response, @service.get_storage_disk_paths
  end

  def test_get_storage_disk_paths_nil_response
    @service.expects(:perform_request).with("getStorageDiskPaths", {}, "return").returns(nil)
    assert_equal [], @service.get_storage_disk_paths
  end

  def test_get_storage_disk_by_path
    @service.expects(:perform_request).with("getStorageDiskByPath", "storageDiskPath" => "thepath").returns(:response)
    assert_equal :response, @service.get_storage_disk_by_path("thepath")
  end

end
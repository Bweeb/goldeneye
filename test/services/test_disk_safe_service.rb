require 'helper'

class TestDiskSafeService < Test::Unit::TestCase

  def setup
    @service = R1::DiskSafe.new
  end

  def test_get_disk_safes_paths
    @service.expects(:perform_request).with("getDiskSafes", {}, ["return", "deviceList"]).returns(:response)
    assert_equal :response, @service.get_disk_safes
  end

  def test_get_disk_safes_nil_response
    @service.expects(:perform_request).with("getDiskSafes", {}, ["return", "deviceList"]).returns(nil)
    assert_equal [], @service.get_disk_safes
  end

end
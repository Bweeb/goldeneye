require 'helper'
require 'goldeneye/cli'

class TestUtilsCli < Test::Unit::TestCase

  def setup
    # Prevents mocha from stubbing non existent methods so that we now if the CLI is failing because
    # something was moved around.
    Mocha::Configuration.prevent(:stubbing_non_existent_method)

    @cdp_api = stub()
    Goldeneye::CDP.stubs(:new).returns(@cdp_api)
  end

  def test_storage_disks
    cdps = [
      { "name" => "cdp1", "ipHost" => "ip1", "apiPort" => "port1" },
      { "name" => "cdp2", "ipHost" => "ip2", "apiPort" => "port2" }
    ]

    cdp1_storage_disks_paths = ["/path/1", "/path/2"]
    cdp2_storage_disks_paths = ["/path/3"]

    path1 = {"capacityBytes" => "10000000000", "freeBytes" => "9000000000", "usageBytes" => "1000000000"}
    path2 = {"capacityBytes" => "1000000000", "freeBytes" => "900000000", "usageBytes" => "100000000"}
    path3 = {"capacityBytes" => "100000000", "freeBytes" => "90000000", "usageBytes" => "10000000"}

    storage_disk_api_1 = stub(:get_storage_disk_paths => cdp1_storage_disks_paths)
    storage_disk_api_1.expects(:get_storage_disk_by_path).with("/path/1").returns(path1)
    storage_disk_api_1.expects(:get_storage_disk_by_path).with("/path/2").returns(path2)

    storage_disk_api_2 = stub(:get_storage_disk_paths => cdp2_storage_disks_paths)
    storage_disk_api_2.expects(:get_storage_disk_by_path).with("/path/3").returns(path3)

    Goldeneye::StorageDisk.expects(:new).with(:url => "http://ip1:port1").returns(storage_disk_api_1)
    Goldeneye::StorageDisk.expects(:new).with(:url => "http://ip2:port2").returns(storage_disk_api_2)

    @cdp_api.expects(:get_registered_cdps).returns(cdps)

    $stdout.expects(:puts).with("CDP cdp1:")
    $stdout.expects(:puts).with("  /path/1:")
    $stdout.expects(:puts).with("    Capacity: 10000000000")
    $stdout.expects(:puts).with("    Free: 9000000000")
    $stdout.expects(:puts).with("    Usage: 1000000000")
    $stdout.expects(:puts).with("  /path/2:")
    $stdout.expects(:puts).with("    Capacity: 1000000000")
    $stdout.expects(:puts).with("    Free: 900000000")
    $stdout.expects(:puts).with("    Usage: 100000000")
    $stdout.expects(:puts).with("CDP cdp2:")
    $stdout.expects(:puts).with("  /path/3:")
    $stdout.expects(:puts).with("    Capacity: 100000000")
    $stdout.expects(:puts).with("    Free: 90000000")
    $stdout.expects(:puts).with("    Usage: 10000000")

    Goldeneye::Cli.start(cli_expand_base_arguments([
      "utils", "storage_disks"
    ]))
  end
end
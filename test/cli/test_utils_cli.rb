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

  def test_list_cdps_devices
    cdps = [
      { "name" => "cdp1", "ipHost" => "ip1", "apiPort" => "port1" },
      { "name" => "cdp2", "ipHost" => "ip2", "apiPort" => "port2" }
    ]

    disk_safe_1 = [{ "description" => "ds1", "deviceList" => [
      {"devicePath" => "/cdp1/dev1", "totalBlocks" => "10000000", "allocatedBlocks" => "5000000", "blockSize" => "1000"},
      {"devicePath" => "/cdp1/dev2", "totalBlocks" => "100000000", "allocatedBlocks" => "2500000", "blockSize" => "2000"}
    ]}]

    disk_safe_2 = [{ "description" => "ds2", "deviceList" => [
      {"devicePath" => "/cdp2/dev1", "totalBlocks" => "10000000", "allocatedBlocks" => "5000000", "blockSize" => "1000"}
    ]}]

    disk_safe_api_1 = stub(:get_disk_safes => disk_safe_1)
    disk_safe_api_2 = stub(:get_disk_safes => disk_safe_2)

    Goldeneye::DiskSafe.expects(:new).with(:url => "http://ip1:port1").returns(disk_safe_api_1)
    Goldeneye::DiskSafe.expects(:new).with(:url => "http://ip2:port2").returns(disk_safe_api_2)

    @cdp_api.expects(:get_registered_cdps).returns(cdps)

    $stdout.expects(:puts).with("CDP cdp1:")
    $stdout.expects(:puts).with("  DiskSafe ds1:")
    $stdout.expects(:puts).with("    /cdp1/dev1: 4.7 GB")
    $stdout.expects(:puts).with("    /cdp1/dev2: 181.6 GB")
    $stdout.expects(:puts).with("CDP cdp2:")
    $stdout.expects(:puts).with("  DiskSafe ds2:")
    $stdout.expects(:puts).with("    /cdp2/dev1: 4.7 GB")

    Goldeneye::Cli.start(cli_expand_base_arguments([
      "utils", "list_cdps_devices"
    ]))
  end
end
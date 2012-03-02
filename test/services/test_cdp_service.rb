require 'helper'

class TestCDPService < Test::Unit::TestCase

  def setup
    @service = R1::CDP.new
  end

  def test_get_registered_cdps
    @service.expects(:perform_request).with("getRegisteredCDPS", {}, "return").returns(:response)
    assert_equal :response, @service.get_registered_cdps
  end

  def test_get_registered_cdps_nil_response
    @service.expects(:perform_request).with("getRegisteredCDPS", {}, "return").returns(nil)
    assert_equal [], @service.get_registered_cdps
  end

end
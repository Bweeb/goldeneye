require 'helper'

class TestBase < Test::Unit::TestCase

  def setup
    CDP::Base.any_instance.stubs(:service).returns(:theservice)
    @api = CDP::Base.new
  end

  def test_initialize_with_default_options
    CDP::Drivers::Savon.expects(:new).with(:theservice, {:my => :option}).returns(:driver)

    assert_equal :driver, CDP::Base.new({:my => :option}).driver
  end

  def test_perform
    @api.driver.expects(:call).with("the_method", 1, 2, 3).returns(:result)
    assert_equal :result, @api.perform_request("the_method", 1, 2, 3)
  end

end
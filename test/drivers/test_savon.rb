require 'helper'

class TestDriversSavon < Test::Unit::TestCase

  def setup
    # @driver = CDP::Drivers::XMLRPC.new
  end

  def test_initialize
    # XMLRPC::Client.expects(:new).with(
    #   @configuration[:host],
    #   @configuration[:path],
    #   @configuration[:port],
    #   @configuration[:proxy_host],
    #   @configuration[:proxy_port],
    #   @configuration[:user],
    #   @configuration[:password],
    #   @configuration[:use_ssl],
    #   @configuration[:timeout]
    # ).returns(:theapi)

    # @driver = CDP::Drivers::XMLRPC.new(@configuration)
    # assert_equal :theapi, @driver.api
  end

  def test_call
    # @driver.api.expects(:call).with("themethod", 1, 2, 3).returns(:response)
    # assert_equal :response, @driver.call("themethod", 1, 2, 3)
  end
end
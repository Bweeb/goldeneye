require 'helper'

class TestXMLRPCDriver < Test::Unit::TestCase

  def setup
    @configuration = {
      :host => "thehost#{rand(1)}",
      :path => "thepath#{rand(1)}",
      :port => "theport#{rand(1)}",
      :proxy_host => "theproxyhost#{rand(1)}",
      :proxy_port => "theproxyport#{rand(1)}",
      :user => "theuser#{rand(1)}",
      :password => "thepassword#{rand(1)}",
      :use_ssl => "theusessl#{rand(1)}",
      :timeout => "thetimeout#{rand(1)}"
    }

    @driver = CDP::Drivers::XMLRPC.new
  end

  def test_initialize
    XMLRPC::Client.expects(:new).with(
      @configuration[:host],
      @configuration[:path],
      @configuration[:port],
      @configuration[:proxy_host],
      @configuration[:proxy_port],
      @configuration[:user],
      @configuration[:password],
      @configuration[:use_ssl],
      @configuration[:timeout]
    ).returns(:theapi)

    @driver = CDP::Drivers::XMLRPC.new(@configuration)
    assert_equal :theapi, @driver.api
  end

  def test_call
    @driver.api.expects(:call).with("themethod", 1, 2, 3).returns(:response)
    assert_equal :response, @driver.call("themethod", 1, 2, 3)
  end
end
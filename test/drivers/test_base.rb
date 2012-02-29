require 'helper'

class TestBaseDriver < Test::Unit::TestCase

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

    @driver = CDP::Drivers::Base.new
  end

  def test_initialize_with_default_options
    CDP.config(@configuration)
    @driver = CDP::Drivers::Base.new

    assert_equal @configuration[:host], @driver.host
    assert_equal @configuration[:path], @driver.path
    assert_equal @configuration[:port], @driver.port
    assert_equal @configuration[:proxy_host], @driver.proxy_host
    assert_equal @configuration[:proxy_port], @driver.proxy_port
    assert_equal @configuration[:user], @driver.user
    assert_equal @configuration[:password], @driver.password
    assert_equal @configuration[:use_ssl], @driver.use_ssl
    assert_equal @configuration[:timeout], @driver.timeout
  end

  def test_initialize_with_config
    @driver = CDP::Drivers::Base.new(@configuration)

    assert_equal @configuration[:host], @driver.host
    assert_equal @configuration[:path], @driver.path
    assert_equal @configuration[:port], @driver.port
    assert_equal @configuration[:proxy_host], @driver.proxy_host
    assert_equal @configuration[:proxy_port], @driver.proxy_port
    assert_equal @configuration[:user], @driver.user
    assert_equal @configuration[:password], @driver.password
    assert_equal @configuration[:use_ssl], @driver.use_ssl
    assert_equal @configuration[:timeout], @driver.timeout
  end

  def test_call
    assert_raise NotImplementedError do
      @driver.call("themethod")
    end
  end
end
require 'helper'

class TestBase < Test::Unit::TestCase

  def setup
    @configuration = {
      :host => "thehost",
      :path => "thepath",
      :port => "theport",
      :proxy_host => "theproxyhost",
      :user => "theuser",
      :password => "thepassword",
      :use_ssl => "theusessl",
      :timeout => "thetimeout"
    }

    @api = CDP::Base.new
  end

  def test_initialize_with_default_options
    XMLRPC::Client.expects(:new).with(
      @configuration[:host],
      @configuration[:path],
      @configuration[:port],
      @configuration[:proxy_host],
      @configuration[:user],
      @configuration[:password],
      @configuration[:use_ssl],
      @configuration[:timeout]
    ).returns(:theapi)

    CDP.config(@configuration)
    @api = CDP::Base.new

    assert_equal @configuration[:host], @api.host
    assert_equal @configuration[:path], @api.path
    assert_equal @configuration[:port], @api.port
    assert_equal @configuration[:proxy_host], @api.proxy_host
    assert_equal @configuration[:user], @api.user
    assert_equal @configuration[:password], @api.password
    assert_equal @configuration[:use_ssl], @api.use_ssl
    assert_equal @configuration[:timeout], @api.timeout
    assert_equal :theapi, @api.api
  end

  def test_initialize_with_config
    XMLRPC::Client.expects(:new).with(
      @configuration[:host],
      @configuration[:path],
      @configuration[:port],
      @configuration[:proxy_host],
      @configuration[:user],
      @configuration[:password],
      @configuration[:use_ssl],
      @configuration[:timeout]
    ).returns(:theapi)

    @api = CDP::Base.new(@configuration)

    assert_equal @configuration[:host], @api.host
    assert_equal @configuration[:path], @api.path
    assert_equal @configuration[:port], @api.port
    assert_equal @configuration[:proxy_host], @api.proxy_host
    assert_equal @configuration[:user], @api.user
    assert_equal @configuration[:password], @api.password
    assert_equal @configuration[:use_ssl], @api.use_ssl
    assert_equal @configuration[:timeout], @api.timeout
    assert_equal :theapi, @api.api
  end

  def test_perform
    @api.api.expects(:call).with("the_method", 1, 2, 3).returns(:result)
    assert_equal :result, @api.perform_request("the_method", 1, 2, 3)
  end

  def test_perform_with_exception
    @api.api.expects(:call).with("the_method", 1, 2, 3).raises(XMLRPC::FaultException.new("Message", 1))

    assert_raise CDP::CDPError do
      @api.perform_request("the_method", 1, 2, 3)
    end
  end

end
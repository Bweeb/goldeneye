require 'helper'

class TestCDP < Test::Unit::TestCase
  def test_config
    configuration =  {
      :logger => "thelogger",
      :host => "thehost",
      :path => "thepath",
      :port => "theport",
      :proxy_host => "theproxyhost",
      :user => "theuser",
      :password => "thepassword",
      :use_ssl => "theusessl",
      :timeout => "thetimeout"
    }

    Logging.expects(:logger).with("thelogger").returns(:thelogger)

    CDP.config(configuration)

    assert_equal configuration[:host], CDP.host
    assert_equal configuration[:path], CDP.path
    assert_equal configuration[:port], CDP.port
    assert_equal configuration[:proxy_host], CDP.proxy_host
    assert_equal configuration[:user], CDP.user
    assert_equal configuration[:password], CDP.password
    assert_equal configuration[:use_ssl], CDP.use_ssl
    assert_equal configuration[:timeout], CDP.timeout
    assert_equal :thelogger, CDP.logger
  end
end

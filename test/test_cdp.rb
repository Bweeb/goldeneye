require 'helper'

class TestCDP < Test::Unit::TestCase
  def test_config
    configuration =  {
      :host => "thehost",
      :path => "thepath",
      :port => "theport",
      :proxy_host => "theproxyhost",
      :user => "theuser",
      :password => "thepassword",
      :use_ssl => "theusessl",
      :timeout => "thetimeout"
    }

    CDP.config do |cdp|
      cdp.host       = configuration[:host]
      cdp.path       = configuration[:path]
      cdp.port       = configuration[:port]
      cdp.proxy_host = configuration[:proxy_host]
      cdp.user       = configuration[:user]
      cdp.password   = configuration[:password]
      cdp.use_ssl    = configuration[:use_ssl]
      cdp.timeout    = configuration[:timeout]
    end

    assert_equal configuration[:host], CDP.host
    assert_equal configuration[:path], CDP.path
    assert_equal configuration[:port], CDP.port
    assert_equal configuration[:proxy_host], CDP.proxy_host
    assert_equal configuration[:user], CDP.user
    assert_equal configuration[:password], CDP.password
    assert_equal configuration[:use_ssl], CDP.use_ssl
    assert_equal configuration[:timeout], CDP.timeout
  end
end

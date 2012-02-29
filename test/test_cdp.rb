require 'helper'

class TestCDP < Test::Unit::TestCase
  def test_config
    configuration =  {
      :url => "theurl",
      :user => "theuser",
      :password => "thepassword",
      :logger => "thelogger",
      :driver => "driver"
    }

    CDP.config(configuration)

    assert_equal configuration[:url], CDP.url
    assert_equal configuration[:user], CDP.user
    assert_equal configuration[:password], CDP.password
    assert_equal configuration[:logger], CDP.logger
    assert_equal configuration[:driver], CDP.driver
  end
end

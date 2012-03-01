require 'helper'

class TestR1 < Test::Unit::TestCase
  def test_config
    configuration =  {
      :url => "theurl",
      :user => "theuser",
      :password => "thepassword"
    }

    R1.config(configuration)

    assert_equal configuration[:url], R1.url
    assert_equal configuration[:user], R1.user
    assert_equal configuration[:password], R1.password
  end
end

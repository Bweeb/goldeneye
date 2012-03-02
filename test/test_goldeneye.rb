require 'helper'

class TestGoldeneye < Test::Unit::TestCase
  def test_config
    configuration =  {
      :url => "theurl",
      :user => "theuser",
      :password => "thepassword"
    }

    Goldeneye.config(configuration)

    assert_equal configuration[:url], Goldeneye.url
    assert_equal configuration[:user], Goldeneye.user
    assert_equal configuration[:password], Goldeneye.password
  end
end

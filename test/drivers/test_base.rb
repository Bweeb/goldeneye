require 'helper'

class TestDriversBase < Test::Unit::TestCase

  def setup
    @configuration = {
      :url => "theurl#{rand(1)}",
      :user => "theuser#{rand(1)}",
      :password => "thepassword#{rand(1)}"
    }

    @driver = Goldeneye::Drivers::Base.new(:theservice)
  end

  def test_initialize_with_default_options
    Goldeneye.config(@configuration)
    @driver = Goldeneye::Drivers::Base.new(:theservice)

    assert_equal "#{@configuration[:url]}/theservice?wsdl", @driver.url
    assert_equal @configuration[:user], @driver.user
    assert_equal @configuration[:password], @driver.password
  end

  def test_initialize_with_config
    @driver = Goldeneye::Drivers::Base.new(:aservice, @configuration)

    assert_equal "#{@configuration[:url]}/aservice?wsdl", @driver.url
    assert_equal @configuration[:user], @driver.user
    assert_equal @configuration[:password], @driver.password
  end

  def test_call
    assert_raise NotImplementedError do
      @driver.call("themethod")
    end
  end
end
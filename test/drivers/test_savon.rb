require 'helper'

class TestDriversSavon < Test::Unit::TestCase

  def setup
    @configuration = {
      :url => "theurl",
      :user => "theuser",
      :password => "thepassword"
    }

    @wsdl = stub(:document= => nil)
    @auth = stub(:basic => nil)
    @http = stub(:auth => @auth)
    @client = stub
    Savon::Client.stubs(:new).yields(@wsdl, @http).returns(@client)

    @driver = CDP::Drivers::Savon.new(:theservice, @configuration)
  end

  def test_initialize
    @wsdl.expects(:document=).with("theurl/theservice?wsdl")
    @auth.expects(:basic).with(@configuration[:user], @configuration[:password])
    @driver = CDP::Drivers::Savon.new(:theservice, @configuration)

    assert_equal @client, @driver.api
  end

  def test_call
    @response = stub(:to_hash => {:the => :response})
    @client.expects(:request).with("themethod", {:the => :options}).returns(@response)

    assert_equal ({:the => :response}), @driver.call("themethod", {:the => :options})
  end
end
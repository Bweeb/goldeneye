require 'helper'

class TestDriversSavon < Test::Unit::TestCase

  def setup
    @configuration = {
      :url => "theurl",
      :user => "theuser",
      :password => "thepassword"
    }

    @wsdl   = stub(:document= => nil)
    @auth   = stub(:basic => nil)
    @http   = stub(:auth => @auth)
    @client = stub

    Savon::Client.stubs(:new).yields(@wsdl, @http).returns(@client)

    @driver = R1::Drivers::Savon.new(:theservice, @configuration)
  end

  def test_initialize
    @wsdl.expects(:document=).with("theurl/theservice?wsdl")
    @auth.expects(:basic).with(@configuration[:user], @configuration[:password])
    @driver = R1::Drivers::Savon.new(:theservice, @configuration)

    assert_equal @client, @driver.api
  end

  def test_call
    @soap     = stub()
    @response = stub(:to_xml => "thexml")

    @soap.expects("body=").with("<the>options</the>")
    @client.expects(:request).with("themethod").yields(@soap).returns(@response)

    assert_equal "thexml", @driver.call("themethod", {:the => :options})
  end
end
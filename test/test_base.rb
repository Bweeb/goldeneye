require 'helper'

class TestBase < Test::Unit::TestCase

  def setup
    @api = R1::Base.new
  end

  def test_class_service
    assert_equal "Base", R1::Base.service
  end

  def test_initialize_with_default_options
    R1::Drivers::Savon.expects(:new).with("Base", {:my => :option}).returns(:driver)

    assert_equal :driver, R1::Base.new({:my => :option}).driver
  end

  def test_perform_request
    xml_response = <<-eos
      <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
        <soap:Body>
          <ns1:getAgentsResponse xmlns:ns1="http://agent.api.server.backup.r1soft.com/">
            <return>
              <attribute1>attr1value</attribute1>
              <attribute2>attr2value</attribute2>
              <repeatable_attribute>repeatable_attribute_value_1</repeatable_attribute>
              <repeatable_attribute>repeatable_attribute_value_2</repeatable_attribute>
            </return>
          </ns1:getAgentsResponse>
        </soap:Body>
      </soap:Envelope>
    eos

    expected_response = {
      "attribute1" => "attr1value",
      "attribute2" => ["attr2value"],
      "repeatable_attribute" => ["repeatable_attribute_value_1", "repeatable_attribute_value_2"]
    }

    @api.driver.expects(:call).with("getAgents", {:the => :options}).returns(xml_response)
    response = @api.perform_request("getAgents", {:the => :options}, "attribute2")

    assert_equal expected_response, response
  end

end
require 'helper'
require 'goldeneye/cli'

class TestBaseCli < Test::Unit::TestCase

  def setup
    # Prevents mocha from stubbing non existent methods so that we now if the CLI is failing because
    # something was moved around.
    Mocha::Configuration.prevent(:stubbing_non_existent_method)

    @base_cli = Goldeneye::BaseCli.new
    @api      = Goldeneye::Base.new

    @base_cli.stubs(:api).returns(@api)
  end

  def test_should_print_multiple_lines_if_enumerable
    @base_cli.expects(:say).with("val1", nil, true)
    @base_cli.expects(:say).with("val2", nil, true)
    @base_cli.output(["val1", "val2"])
  end
end
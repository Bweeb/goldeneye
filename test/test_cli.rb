require 'helper'
require 'goldeneye/cli'

class TestCli < Test::Unit::TestCase

  def setup
    # Prevents mocha from stubbing non existent methods so that we now if the CLI is failing because
    # something was moved around.
    Mocha::Configuration.prevent(:stubbing_non_existent_method)
  end

  def test_should_print_version
    $stdout.expects(:puts).with(Goldeneye::VERSION)
    Goldeneye::Cli.start(cli_expand_base_arguments(["version"]))
  end

end
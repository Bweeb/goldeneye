require 'test/unit'

# Use TURN if available
begin
  require 'turn' if ENV['TURN']
rescue LoadError
end

require 'cdp'
require 'mocha'

CDP.logger.level = :info

class Test::Unit::TestCase

  def cli_expand_base_arguments(options)
    arguments = []
    options + arguments
  end

end
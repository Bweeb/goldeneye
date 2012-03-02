require 'test/unit'

# Use TURN if available
begin
  require 'turn' if ENV['TURN']
rescue LoadError
end

require 'r1'
require 'mocha'

R1.logger.level = :info

class Test::Unit::TestCase

  def cli_expand_base_arguments(options)
    arguments = []
    options + arguments
  end

end
require 'test/unit'

# Use TURN if available
begin
  require 'turn' if ENV['TURN']
rescue LoadError
end

require 'goldeneye'
require 'mocha'

Goldeneye.logger.level = :info

class Test::Unit::TestCase

  def cli_expand_base_arguments(options)
    arguments = ["--api-username", "thelogin", "--api-password", "thekey", "--api-url", "theurl"]
    options + arguments
  end

end
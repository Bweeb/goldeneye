require 'thor'
require 'r1'
require 'r1/version'
require 'r1/cli/base_cli'

module R1
  class Cli < Thor
    # register(ServerCli,  'server', 'server <command>', 'Server commands')

    desc "version", "Outputs the current program version"
    def version
      say R1::VERSION
    end
  end
end

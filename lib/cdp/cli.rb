require 'cdp'
require 'thor'
require 'cdp/version'
require 'cdp/cli/base_cli'
# require 'cdp/cli/server_cli'

module CDP
  class Cli < Thor
    # register(ServerCli,  'server', 'server <command>', 'Server commands')

    desc "version", "Outputs the current program version"
    def version
      say CDP::VERSION
    end
  end
end

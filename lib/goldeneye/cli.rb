require 'thor'
require 'goldeneye'
require 'goldeneye/version'
require 'goldeneye/cli/base_cli'
require 'goldeneye/cli/utils_cli'

module Goldeneye
  class Cli < Thor
    register(UtilsCli,  'utils', 'utils <command>', 'Utils commands')

    desc "version", "Outputs the current program version"
    def version
      say Goldeneye::VERSION
    end
  end
end

require 'yaml'
require 'thor'
require 'thor/group'

module CDP
  class BaseCli < Thor
    include Thor::Actions

    class << self
      # Overrides the default banner implementation to output the whole command
      def banner(task, namespace = true, subcommand = false)
        "#{self.namespace.split(":").join(" ")} #{task.formatted_usage(self, false, false)}"
      end

      # Convenience method to get the namespace from the class name. It's the
      # same as Thor default except that the "_cli" at the end of the class
      # is removed.
      def namespace(name=nil)
        if name
          super
        else
          @namespace ||= super.sub(/_cli$/, '')
        end
      end

      # Retrieves default options coming from a configuration file, if any.
      def default_option(key)
        @@yaml ||= begin
          file = File.join(File.expand_path(ENV['HOME']), '.cdp.yml')
          if File.exists?(file)
            YAML::load(File.open(file))
          else
            {}
          end
        end

        @@yaml[key.to_s]
      end
    end

    # Default required options
    class_option :api_username, :type => :string, :desc => "API USERNAME; Required.",  :aliases => ["-U", "--api-username"]
    class_option :api_password, :type => :string, :desc => "API PASSWORD; Required.", :aliases => ["-P", "--api-password"]
    class_option :api_url,   :type => :string, :desc => "API URL; Required.", :aliases => ["-H", "--api-url"]

    no_tasks do
      def api
        raise NotImplementedError
      end

      # prints one result element per line, in case it is a list
      def output(result="", color=nil, force_new_line=(result.to_s !~ /( |\t)$/))
        Array(result).each do |entry|
          say(entry, color, force_new_line)
        end
      end
    end

    protected

    def configure
      CDP.config(
        :url => present_or_exit(:api_url, :url, "api_url required"),
        :user => present_or_exit(:api_username, :username, "api_username required"),
        :password => present_or_exit(:api_password, :password, "api_password required")
      )
    end

    def present_or_exit(options_key, default_option_key, message)
      options[options_key] || BaseCli.default_option(default_option_key) || (say(message) && raise(SystemExit))
    end
  end
end
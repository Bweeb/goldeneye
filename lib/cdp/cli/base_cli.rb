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
    class_option :api_host,   :type => :string, :desc => "API HOST; Required.", :aliases => ["-H", "--api-host"]

    # Additional options
    class_option :api_path, :type => :string, :desc => "API PATH; Default to xmlrpc.", :aliases => ["-PA", "--api-path"]
    class_option :api_port, :type => :numeric, :desc => "API PORT; Default to 8084.", :aliases => ["-PT", "--api-port"]
    class_option :api_proxy_host, :type => :string, :desc => "API PROXY HOST;", :aliases => ["-PH", "--api-proxy-host"]
    class_option :api_proxy_port, :type => :numeric, :desc => "API PROXY PORT;", :aliases => ["-PP", "--api-proxy-port"]
    class_option :api_use_ssl, :desc => "API USE SSL;", :aliases => ["-S", "--api-use-ssl"]
    class_option :api_timeout, :type => :numeric, :desc => "API TIMEOUT;", :aliases => ["-T", "--api-timeout"]

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
        :host => present_or_exit(:api_host, :host, "api_host required"),
        :path => options_or_default(:api_path, :path),
        :port => options_or_default(:api_port, :port),
        :proxy_host => options_or_default(:api_host, :proxy_host),
        :proxy_port => options_or_default(:api_port, :proxy_port),
        :user => present_or_exit(:api_username, :username, "api_username required"),
        :password => present_or_exit(:api_password, :password, "api_password required"),
        :use_ssl => options_or_default(:api_use_ssl, :ssl),
        :timeout => options_or_default(:api_timeout, :timeout)
      )
    end

    def present_or_exit(options_key, default_option_key, message)
      options_or_default(options_key, default_option_key) || (say(message) && raise(SystemExit))
    end

    def options_or_default(options_key, default_option_key)
        options[options_key] || BaseCli.default_option(default_option_key)
    end
  end
end
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

require 'rails/commands/server'

module Rails
    class Server
        alias :default_options_bk :default_options
        def default_options
            default_options_bk.merge!(Host: ENV["vb_ip"], Port: ENV["vb_port"])
        end
    end
end

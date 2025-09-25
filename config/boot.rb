ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

# Fix for ActiveSupport::Logger compatibility
require 'logger' unless defined?(Logger)
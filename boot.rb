# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

APP_ROOT = File.expand_path("#{File.dirname(__FILE__)}")

(Dir["#{APP_ROOT}/lib/*rb"] + Dir["#{APP_ROOT}/interactions/*rb"] + Dir["#{APP_ROOT}/use_cases/*rb"]).each do |f|
  require f
end

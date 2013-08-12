# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

APP_ROOT = File.expand_path("#{File.dirname(__FILE__)}")

%w[lib domain interactions].each do |sub_dir|
  Dir["#{APP_ROOT}/#{sub_dir}/*rb"].each do |f|
    require f
  end
end

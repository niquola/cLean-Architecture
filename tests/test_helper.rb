require "minitest/autorun"
require "wrong"
require 'wrong/adapters/minitest'
require 'active_support'
require 'active_support/dependencies'

APP_ROOT = File.expand_path("#{File.dirname(__FILE__)}/..")

(Dir["#{APP_ROOT}/lib/*rb"] + Dir["#{APP_ROOT}/interactions/*rb"] + Dir["#{APP_ROOT}/use_cases/*rb"]).each do |f|
  require f
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'bundler/setup'

require 'active_support'
require 'active_support/log_subscriber'

require 'action_controller'
require 'action_controller/log_subscriber'

require 'faraday'
require 'faraday_middleware'

require 'logstasher'

require 'faraday-logstasher'
require 'minitest/autorun'

ActiveSupport.test_order = :random

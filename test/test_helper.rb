# encoding: utf-8
require 'thumbtack'
require 'minitest/autorun'

if ENV.fetch('COVERAGE', false)
  require 'simplecov'
  SimpleCov.start
end

def mock_client_get(url, params, response)
  client = Minitest::Mock.new
  client.expect(:get, response, [url, params].compact)
  client
end

def mock_client_action(url, params)
  client = Minitest::Mock.new
  client.expect(:action, { 'result' => 'done' }, [url, params])
  client
end

include Thumbtack

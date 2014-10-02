# encoding: utf-8
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'thumbtack'
require 'minitest/autorun'

def mock_client_get(url, params, response)
  client = Minitest::Mock.new
  client.expect(:get, response, [url, params].compact)
  client
end

def mock_client_action(url, params, response)
  client = Minitest::Mock.new
  client.expect(:action, response, [url, params].compact)
  client
end

include Thumbtack

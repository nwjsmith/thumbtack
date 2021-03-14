# frozen_string_literal: true

if ENV.fetch("COVERAGE", false)
  require "codecov"
  require "simplecov"
  SimpleCov.start do
    add_filter "test/"
    formatter SimpleCov::Formatter::MultiFormatter.new([
      SimpleCov::Formatter::HTMLFormatter,
      SimpleCov::Formatter::Codecov
    ])
  end
end

require "thumbtack"
require "minitest/autorun"

def mock_client_get(url, params, response)
  client = Minitest::Mock.new
  client.expect(:get, response, [url, params].compact)
  client
end

def mock_client_action(url, params)
  client = Minitest::Mock.new
  client.expect(:action, {"result" => "done"}, [url, params])
  client
end

Minitest::Test.include Thumbtack

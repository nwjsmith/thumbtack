# frozen_string_literal: true

require 'test_helper'

module Integration
  class BasicAdapterTest < Minitest::Test
    def setup
      path = File.expand_path('../../../auth_token.txt', __FILE__)
      auth_token = File.open(path).read.strip
      @username, @token = auth_token.split(':')
      @adapter = Adapters::BasicAdapter.new(@username, @token)
    end

    def test_requests_return_parsed_json
      response = @adapter.get('/user/api_token')
      assert_equal({ 'result' => @token }, response)
    end

    def test_request_query_parameters
      response = @adapter.get('/posts/recent', tag: 'thumbtack-test-xyz123')
      assert_equal([], response['posts'])
    end
  end
end

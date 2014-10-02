# encoding: utf-8

require 'test_helper'

module Integration
  class ClientTest < Minitest::Test
    def setup
      path = File.expand_path('../../../auth_token.txt', __FILE__)
      auth_token = File.open(path).read.strip
      @username, @token = auth_token.split(':')
      @client = Client.new(@username, @token)
    end

    def test_requests_return_parsed_json
      response = @client.get('/user/api_token')
      assert_equal({ 'result' => @token }, response)
    end

    def test_request_query_parameters
      response = @client.get('/posts/recent', tag: 'thumbtack-test-query-params')
      assert_equal([] , response['posts'])
    end

    def test_action_command_method
      response = @client.action('/tags/delete', tag: 'thumbtack-test-command')
      assert_equal(@client, response)
    end
  end
end

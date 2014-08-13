# encoding: utf-8

require 'test_helper'

class ClientTest < Minitest::Test
  def setup
    @client = Client.new(username, token)
  end

  def test_requests_return_parsed_json
    response = @client.get('/user/api_token')
    assert_equal({ 'result' => token }, response)
  end

  def test_request_query_parameters
    response = @client.get('/tags/delete', tag: 'thumbtack-test-query-params')
    assert_equal({ 'result' => 'done' }, response)
  end

  def test_posts
    assert_instance_of Posts, @client.posts
  end

  def test_tags
    assert_instance_of Tags, @client.tags
  end

  def test_user
    assert_instance_of User, @client.user
  end
end

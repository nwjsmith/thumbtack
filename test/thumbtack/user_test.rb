# encoding: utf-8

require 'test_helper'

class TagsTest < Minitest::Test
  def mock_client(url, params, response)
    client = Minitest::Mock.new
    client.expect(:get, response, [url, params].compact)
    client
  end

  def test_secret
    client = mock_client('/user/secret',
                         nil,
                         { 'result' => '6493a84f72d86e7de130' })
    user = User.new(client)

    assert_equal '6493a84f72d86e7de130', user.secret
  end

  def test_api_token
    client = mock_client('/user/api_token',
                         nil,
                         { 'result' => 'XOG86E7JIYMI' })
    user = User.new(client)

    assert_equal 'XOG86E7JIYMI', user.api_token
  end
end

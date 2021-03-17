# typed: true
# frozen_string_literal: true

require "test_helper"

class UserTest < Minitest::Test
  def test_secret
    client = mock_client_get(
      "/user/secret",
      nil,
      "result" => "6493a84f72d86e7de130"
    )
    user = User.new(client)

    assert_equal "6493a84f72d86e7de130", user.secret
  end

  def test_api_token
    client = mock_client_get(
      "/user/api_token",
      nil,
      "result" => "XOG86E7JIYMI"
    )
    user = User.new(client)

    assert_equal "XOG86E7JIYMI", user.api_token
  end
end

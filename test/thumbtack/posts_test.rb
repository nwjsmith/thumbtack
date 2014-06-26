# encoding: utf-8

require 'test_helper'

class PostsTest < Minitest::Test
  def test_update
    client = Minitest::Mock.new
    response = { 'update_time' => '2014-06-26T19:01:33Z' }
    client.expect(:get, response, ['/posts/update'])
    posts = Posts.new(client)

    assert_equal '2014-06-26T19:01:33Z', posts.update
  end
end

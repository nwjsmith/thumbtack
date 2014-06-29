# encoding: utf-8

require 'test_helper'

class PostsTest < Minitest::Test
  def test_update
    client = Minitest::Mock.new
    response = { 'update_time' => '2014-06-26T19:01:33Z' }
    client.expect(:get, response, ['/posts/update'])
    posts = Posts.new(client)

    assert_equal '2014-06-26T19:01:33Z', posts.update
    client.verify
  end

  def test_add
    client = Minitest::Mock.new
    response = { 'result_code' => 'done' }
    client.expect(:get, response,
                  ['/posts/add',
                   { url: 'http://example.org', description: 'example.org' }])
    posts = Posts.new(client)

    assert_equal posts, posts.add('http://example.org', 'example.org')
    client.verify
  end

  def test_add_with_tags
    client = Minitest::Mock.new
    response = { 'result_code' => 'done' }
    client.expect(:get, response,
                  ['/posts/add',
                   { url: 'http://example.org',
                     description: 'example.org',
                     tags: 'thumbtack test' }])
    posts = Posts.new(client)

    assert_equal posts,
      posts.add('http://example.org', 'example.org', tags: 'thumbtack test')
    client.verify
  end

  def test_delete
    client = Minitest::Mock.new
    response = { 'result_code' => 'done' }
    client.expect(:get, response,
                  ['/posts/delete', { url: 'http://example.org' }])
    posts = Posts.new(client)

    assert_equal posts, posts.delete('http://example.org')
    client.verify
  end
end

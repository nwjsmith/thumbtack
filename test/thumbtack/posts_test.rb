# encoding: utf-8

require 'test_helper'

class PostsTest < Minitest::Test
  def mock_client(url, params, response)
    client = Minitest::Mock.new
    client.expect(:get, response, [url, params].compact)
    client
  end

  def test_update
    client = mock_client('/posts/update',
                         nil,
                         { 'update_time' => '2014-06-26T19:01:33Z' })
    posts = Posts.new(client)

    assert_equal '2014-06-26T19:01:33Z', posts.update
    client.verify
  end

  def test_add
    client = mock_client('/posts/add',
                         { url: 'http://example.org',
                           description: 'example.org' },
                         { 'result_code' => 'done' })
    posts = Posts.new(client)

    assert_equal posts, posts.add('http://example.org', 'example.org')
    client.verify
  end

  def test_add_with_tags
    client = mock_client('/posts/add',
                         { url: 'http://example.org',
                           description: 'example.org',
                           tags: 'thumbtack test' },
                         { 'result_code' => 'done' })
    posts = Posts.new(client)

    assert_equal posts,
      posts.add('http://example.org', 'example.org', tags: 'thumbtack test')
    client.verify
  end

  def test_delete
    client = mock_client('/posts/delete',
                         { url: 'http://example.org' },
                         { 'result_code' => 'done' })
    posts = Posts.new(client)

    assert_equal posts, posts.delete('http://example.org')
    client.verify
  end

  def test_get
    client = mock_client('/posts/get',
                         { url: 'http://example.org' },
                         {
                           'date' => '2014-06-29T16:57:45Z',
                           'user' => 'nwjsmith',
                           'posts' => [{
                             'href' => 'http://example.org',
                             'description' => 'example.org',
                             'extended' => '',
                             'meta' => '46ca40b9b92ee0ea1284785a5d2a9b38',
                             'hash' => 'dab521de65f9250b4cca7383feef67dc',
                             'time' => '2014-06-29T16:57:45Z',
                             'shared' => 'yes',
                             'toread' => 'no',
                             'tags' => 'test123'
                           }]
                         })
    posts = Posts.new(client)
    response = posts.get(url: 'http://example.org')

    assert_equal 1, response.size
    assert_equal 'http://example.org', response.first.href
    client.verify
  end
end

# encoding: utf-8

require 'test_helper'

class PostsTest < Minitest::Test
  def test_update
    client = mock_client_get(
      '/posts/update',
      nil,
      'update_time' => '2014-06-26T19:01:33Z'
    )
    posts = Posts.new(client)

    assert_equal DateTime.new(2014, 6, 26, 19, 1, 33), posts.update
    client.verify
  end

  def test_add
    client = mock_client_action(
      '/posts/add',
      url: 'http://example.org',
      description: 'example.org'
    )
    posts = Posts.new(client)

    assert_equal posts, posts.add('http://example.org', 'example.org')
    client.verify
  end

  def test_add_with_tags
    client = mock_client_action(
      '/posts/add',
      url: 'http://example.org',
      description: 'example.org',
      tags: 'thumbtack test'
    )
    posts = Posts.new(client)

    assert_equal posts,
                 posts.add(
                   'http://example.org',
                   'example.org',
                   tags: %w(thumbtack test)
                 )
    client.verify
  end

  def test_delete
    client = mock_client_action(
      '/posts/delete',
      url: 'http://example.org'
    )
    posts = Posts.new(client)

    assert_equal posts, posts.delete('http://example.org')
    client.verify
  end

  def test_get
    client = mock_client_get(
      '/posts/get',
      { url: 'http://example.org' },
      'date' => '2014-06-29T16:57:45Z',
      'user' => 'nwjsmith',
      'posts' => [example_post_hash]
    )
    posts = Posts.new(client)
    response = posts.get(url: 'http://example.org')

    assert_equal 1, response.size
    assert_equal 'http://example.org', response.first.href
    client.verify
  end

  def test_recent
    client = mock_client_get(
      '/posts/recent',
      { tag: 'webdev' },
      'date' => '2014-06-29T16:57:45Z',
      'user' => 'nwjsmith',
      'posts' => [example_post_hash]
    )
    posts = Posts.new(client)
    response = posts.recent(tag: 'webdev')

    assert_equal 1, response.size
    assert_equal 'http://example.org', response.first.href
    client.verify
  end

  def test_all
    client = mock_client_get('/posts/all', { tag: 'webdev' }, [example_post_hash])
    posts = Posts.new(client)
    response = posts.all(tag: 'webdev')

    assert_equal 1, response.size
    assert_equal 'http://example.org', response.first.href
    client.verify
  end

  def test_suggest
    client = mock_client_get(
      '/posts/suggest',
      { url: 'http://blog.com' },
      [
        { 'popular' => %w(blog blogs people) },
        { 'recommended' => %w(blog writing weblog) }
      ]
    )
    posts = Posts.new(client)
    response = posts.suggest('http://blog.com')

    assert_equal 'blog', response.popular.first
    assert_equal 'weblog', response.recommended.last
    client.verify
  end

  def test_dates
    client = mock_client_get(
      '/posts/dates',
      { tag: 'argentina' },
      'user' => 'user',
      'tag' => 'argentina',
      'dates' => {
        '2010-11-29' => '5',
        '2010-11-28' => '15',
        '2010-11-25' => '2',
        '2010-11-23' => '7',
        '2010-11-22' => '20',
        '2010-11-21' => '16',
        '2010-11-19' => '4'
      }
    )
    posts = Posts.new(client)
    response = posts.dates(tag: 'argentina')

    assert_equal(
      {
        Date.new(2010, 11, 29) => 5,
        Date.new(2010, 11, 28) => 15,
        Date.new(2010, 11, 25) => 2,
        Date.new(2010, 11, 23) => 7,
        Date.new(2010, 11, 22) => 20,
        Date.new(2010, 11, 21) => 16,
        Date.new(2010, 11, 19) => 4
      },
      response
    )
    client.verify
  end

  private

  def example_post_hash
    {
      'href' => 'http://example.org',
      'description' => 'example.org',
      'extended' => '',
      'meta' => '46ca40b9b92ee0ea1284785a5d2a9b38',
      'hash' => 'dab521de65f9250b4cca7383feef67dc',
      'time' => '2014-06-29T16:57:45Z',
      'shared' => 'yes',
      'toread' => 'no',
      'tags' => 'webdev'
    }
  end
end

# encoding: utf-8

require 'test_helper'

class PostTest < Minitest::Test
  def test_from_hash
    hash = {
      'href' => 'http://example.org',
      'description' => 'example.org',
      'extended' => '',
      'meta' => '46ca40b9b92ee0ea1284785a5d2a9b38',
      'hash' => 'dab521de65f9250b4cca7383feef67dc',
      'time' => '2014-06-29T16:57:45Z',
      'shared' => 'yes',
      'toread' => 'no',
      'tags' => 'test123'
    }
    post = Post.from_hash(hash)

    assert_equal 'http://example.org', post.href
    assert_equal 'example.org', post.description
    assert_equal '', post.extended
    assert_equal '46ca40b9b92ee0ea1284785a5d2a9b38', post.meta
    assert_equal 'dab521de65f9250b4cca7383feef67dc', post.hash
    assert_equal '2014-06-29T16:57:45Z', post.time
    assert_equal 'yes', post.shared
    assert_equal 'no', post.toread
    assert_equal 'test123', post.tags
  end
end

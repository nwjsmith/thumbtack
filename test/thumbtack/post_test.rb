# typed: true
# frozen_string_literal: true

require "test_helper"

class PostTest < Minitest::Test
  def test_from_hash
    hash = {
      "href" => "http://example.org",
      "description" => "example.org",
      "extended" => "",
      "meta" => "46ca40b9b92ee0ea1284785a5d2a9b38",
      "hash" => "dab521de65f9250b4cca7383feef67dc",
      "time" => "2014-06-29T16:57:45Z",
      "shared" => "yes",
      "toread" => "no",
      "tags" => "test123 another"
    }
    post = Post.from_hash(hash)

    assert_equal "http://example.org", post.href
    assert_equal "example.org", post.description
    assert_equal "", post.extended
    assert_equal "46ca40b9b92ee0ea1284785a5d2a9b38", post.meta
    assert_equal "dab521de65f9250b4cca7383feef67dc", post.digest
    assert_equal Time.new(2014, 6, 29, 16, 57, 45), post.time
    assert_equal true, post.shared
    assert_equal false, post.toread
    assert_equal %w[test123 another], post.tags
  end
end

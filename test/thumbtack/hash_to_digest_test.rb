# frozen_string_literal: true

require "test_helper"

class HashToDigestTest < Minitest::Test
  def test_rename
    assert_equal(
      {
        "digest" => "value", "other" => "value"
      },
      HashToDigest.rename("hash" => "value", "other" => "value")
    )
  end
end

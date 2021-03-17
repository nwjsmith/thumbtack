# typed: true
# frozen_string_literal: true

require "test_helper"

class TagsTest < Minitest::Test
  def test_update
    client = mock_client_get(
      "/tags/get",
      nil,
      "activedesktop" => "1",
      "xpi" => "1"
    )
    tags = Tags.new(client)

    assert_equal(
      {
        "activedesktop" => 1,
        "xpi" => 1
      },
      tags.get
    )

    client.verify
  end

  def test_delete
    client = mock_client_action(
      "/tags/delete",
      tag: "argentina"
    )
    tags = Tags.new(client)

    assert_equal tags, tags.delete("argentina")
    client.verify
  end

  def test_rename
    client = mock_client_action(
      "/tags/rename",
      old: "argentina",
      new: "evita"
    )
    tags = Tags.new(client)

    assert_equal tags, tags.rename("argentina", "evita")
    client.verify
  end
end

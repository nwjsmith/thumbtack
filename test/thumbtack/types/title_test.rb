# typed: false
# frozen_string_literal: true

require "test_helper"

class TitleTest < Minitest::Test
  def test_validate
    assert_equal Types::Title, Types::Title.validate("")
    assert_equal Types::Title, Types::Title.validate("x" * 255)

    assert_raises(ValidationError) do
      Types::Title.validate("x" * 256)
    end
  end

  def test_serialize
    assert_equal "title", Types::Title.serialize("title")
  end

  def test_deserialize
    assert_equal "title", Types::Title.deserialize("title")
  end
end

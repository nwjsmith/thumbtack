# typed: false
# frozen_string_literal: true

require "test_helper"

class IntegerTest < Minitest::Test
  def test_validate
    assert_equal Types::Integer, Types::Integer.validate(0)
    assert_equal Types::Integer, Types::Integer.validate(2**32)

    assert_raises(ValidationError) do
      Types::Integer.validate(-1)
    end

    assert_raises(ValidationError) do
      Types::Integer.validate(2**32 + 1)
    end
  end

  def test_serialize
    assert_equal 42, Types::Integer.serialize(42)
  end

  def test_deserialize
    assert_equal 42, Types::Integer.deserialize(42)
  end
end

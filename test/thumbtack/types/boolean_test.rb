# typed: false
# frozen_string_literal: true

require "test_helper"

class BooleanTest < Minitest::Test
  def test_validate
    assert_equal Types::Boolean, Types::Boolean.validate(true)
    assert_equal Types::Boolean, Types::Boolean.validate(false)

    assert_raises(ValidationError) do
      Types::Boolean.validate("nope")
    end

    assert_raises(ValidationError) do
      Types::Boolean.validate(nil)
    end
  end

  def test_serialize
    assert_equal "yes", Types::Boolean.serialize(true)
    assert_equal "no", Types::Boolean.serialize(false)
  end

  def test_deserialize
    assert_equal true, Types::Boolean.deserialize("yes")
    assert_equal false, Types::Boolean.deserialize("no")
  end
end

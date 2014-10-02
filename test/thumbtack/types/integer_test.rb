# encoding: utf-8

require 'test_helper'

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

  def test_to_parameter
    assert_equal 42, Types::Integer.to_parameter(42)
  end

  def test_from_parameter
    assert_equal 42, Types::Integer.from_parameter(42)
  end
end

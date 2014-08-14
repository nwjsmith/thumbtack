# encoding: utf-8

require 'test_helper'

class BooleanTest < Minitest::Test
  def test_validate
    assert_equal Types::Boolean, Types::Boolean.validate(true)
    assert_equal Types::Boolean, Types::Boolean.validate(false)

    assert_raises(Types::ValidationError) do
      Types::Boolean.validate('nope')
    end

    assert_raises(Types::ValidationError) do
      Types::Boolean.validate(nil)
    end
  end

  def test_to_parameter
    assert_equal 'yes', Types::Boolean.to_parameter(true)
    assert_equal 'no', Types::Boolean.to_parameter(false)
  end

  def test_from_parameter
    assert_equal true, Types::Boolean.from_parameter('yes')
    assert_equal false, Types::Boolean.from_parameter('no')
  end
end

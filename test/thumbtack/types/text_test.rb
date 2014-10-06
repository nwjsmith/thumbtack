# encoding: utf-8

require 'test_helper'

class TextTest < Minitest::Test
  def test_validate
    assert_equal Types::Text, Types::Text.validate('')
    assert_equal Types::Text, Types::Text.validate('x' * 65_536)

    assert_raises(ValidationError) do
      Types::Text.validate('x' * 65_537)
    end
  end

  def test_to_parameter
    assert_equal 'text', Types::Text.to_parameter('text')
  end

  def test_from_parameter
    assert_equal 'text', Types::Text.from_parameter('text')
  end
end

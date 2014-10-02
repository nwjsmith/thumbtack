# encoding: utf-8

require 'test_helper'

class TitleTest < Minitest::Test
  def test_validate
    assert_equal Types::Title, Types::Title.validate('')
    assert_equal Types::Title, Types::Title.validate('x' * 255)

    assert_raises(ValidationError) do
      Types::Title.validate('x' * 256)
    end
  end

  def test_to_parameter
    assert_equal 'title', Types::Title.to_parameter('title')
  end

  def test_from_parameter
    assert_equal 'title', Types::Title.from_parameter('title')
  end
end

# encoding: utf-8

require 'test_helper'

class URLTest < Minitest::Test
  def test_validate
    assert_equal Types::URL, Types::URL.validate('http://pinboard.in')

    assert_raises(Types::ValidationError) do
      Types::URL.validate('scp://pinboard.in')
    end
  end

  def test_to_parameter
    value = 'http://pinboard.in'
    assert_equal value, Types::URL.to_parameter(value)
  end

  def test_from_parameter
    value = 'http://pinboard.in'
    assert_equal value, Types::URL.from_parameter(value)
  end
end

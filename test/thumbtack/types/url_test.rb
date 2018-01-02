# frozen_string_literal: true

require 'test_helper'

class URLTest < Minitest::Test
  def test_validate
    assert_equal Types::URL, Types::URL.validate('http://pinboard.in')

    assert_raises(ValidationError) do
      Types::URL.validate('scp://pinboard.in')
    end
  end

  def test_serialize
    value = 'http://pinboard.in'
    assert_equal value, Types::URL.serialize(value)
  end

  def test_deserialize
    value = 'http://pinboard.in'
    assert_equal value, Types::URL.deserialize(value)
  end
end

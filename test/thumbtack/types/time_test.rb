# frozen_string_literal: true

require 'test_helper'

class TimeTest < Minitest::Test
  def test_validate
    assert_equal Types::Time, Types::Time.validate(::Time.now)

    assert_raises(ValidationError) do
      Types::Time.validate ::Time.new(0, 1, 1)
    end

    assert_raises(ValidationError) do
      Types::Time.validate ::Time.new(2101, 1, 1)
    end
  end

  def test_serialize
    assert_equal '2010-12-11T19:48:02Z',
                 Types::Time.serialize(::Time.new(2010, 12, 11, 19, 48, 2))
  end

  def test_deserialize
    assert_equal ::Time.new(2010, 12, 11, 19, 48, 2),
                 Types::Time.deserialize('2010-12-11T19:48:02Z')
  end

  def test_deserialize_from_note
    assert_equal ::Time.new(2010, 12, 11, 19, 48, 2),
                 Types::Time.deserialize_from_note('2010-12-11 19:48:02')
  end
end

# encoding: utf-8

require 'test_helper'

class DateTimeTest < Minitest::Test
  def test_validate
    assert_equal Types::DateTime, Types::DateTime.validate(::DateTime.now)

    assert_raises(ValidationError) do
      Types::DateTime.validate ::DateTime.new(0, 1, 1)
    end

    assert_raises(ValidationError) do
      Types::DateTime.validate ::DateTime.new(2101, 1, 1)
    end
  end

  def test_serialize
    assert_equal '2010-12-11T19:48:02Z',
                 Types::DateTime.serialize(
                   ::DateTime.new(2010, 12, 11, 19, 48, 2))
  end

  def test_deserialize
    assert_equal ::DateTime.new(2010, 12, 11, 19, 48, 2),
                 Types::DateTime.deserialize('2010-12-11T19:48:02Z')
  end

  def test_deserialize_from_note
    assert_equal ::DateTime.new(2010, 12, 11, 19, 48, 2),
                 Types::DateTime.deserialize_from_note('2010-12-11 19:48:02')
  end
end

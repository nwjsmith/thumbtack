# typed: false
# frozen_string_literal: true

require "test_helper"

class DateTest < Minitest::Test
  def test_validate
    assert_equal Types::Date, Types::Date.validate(::Date.today)

    assert_raises(ValidationError) do
      Types::Date.validate ::Date.new(0, 1, 1)
    end

    assert_raises(ValidationError) do
      Types::Date.validate ::Date.new(2101, 1, 1)
    end
  end

  def test_serialize
    assert_equal "2010-12-11",
      Types::Date.serialize(::Date.new(2010, 12, 11))
  end

  def test_deserialize
    assert_equal ::Date.new(2010, 12, 11),
      Types::Date.deserialize("2010-12-11")
  end
end

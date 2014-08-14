# encoding: utf-8

require 'test_helper'

class DateTest < Minitest::Test
  def test_validate
    assert_equal Types::Date, Types::Date.validate(::Date.today)

    assert_raises(Types::ValidationError) do
      Types::Date.validate ::Date.new(0, 1, 1)
    end

    assert_raises(Types::ValidationError) do
      Types::Date.validate ::Date.new(2101, 1, 1)
    end
  end

  def test_to_parameter
    assert_equal '2010-12-11',
      Types::Date.to_parameter(::Date.new(2010, 12, 11))
  end

  def test_from_parameter
    assert_equal ::Date.new(2010, 12, 11),
      Types::Date.from_parameter('2010-12-11')
  end
end

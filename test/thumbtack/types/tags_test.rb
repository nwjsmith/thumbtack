# encoding: utf-8

require 'test_helper'

class TagsTest < Minitest::Test
  def test_validate
    assert_equal Types::Tags, Types::Tags.validate('argentina')
    assert_equal Types::Tags, Types::Tags.validate(['argentina'])
    assert_equal Types::Tags, Types::Tags.validate(['.private'])

    assert_raises(ValidationError) do
      Types::Tags.validate [('x' * 256)]
    end

    assert_raises(ValidationError) do
      Types::Tags.validate ['comma,']
    end
  end

  def test_to_parameter
    assert_equal 'one', Types::Tags.to_parameter('one')
    assert_equal 'one two', Types::Tags.to_parameter(['one', 'two'])
    assert_equal 'padding', Types::Tags.to_parameter([' padding '])
  end

  def test_from_parameter
    assert_equal ['one', 'two'], Types::Tags.from_parameter('one two')
  end
end

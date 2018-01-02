# frozen_string_literal: true

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

  def test_serialize
    assert_equal 'one', Types::Tags.serialize('one')
    assert_equal 'one two', Types::Tags.serialize(%w[one two])
    assert_equal 'padding', Types::Tags.serialize([' padding '])
  end

  def test_deserialize
    assert_equal %w[one two], Types::Tags.deserialize('one two')
  end
end

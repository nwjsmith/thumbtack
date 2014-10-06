# encoding: utf-8

require 'test_helper'

class MD5Test < Minitest::Test
  def test_validate
    assert_equal Types::MD5,
                 Types::MD5.validate('437b930db84b8079c2dd804a71936b5f')

    assert_raises(ValidationError) do
      Types::MD5.validate('0' * 33)
    end

    assert_raises(ValidationError) do
      Types::MD5.validate('gggggggggggggggggggggggggggggggg')
    end
  end

  def test_to_parameter
    assert_equal '437b930db84b8079c2dd804a71936b5f',
                 Types::MD5.to_parameter('437b930db84b8079c2dd804a71936b5f')
  end

  def test_from_parameter
    assert_equal '437b930db84b8079c2dd804a71936b5f',
                 Types::MD5.from_parameter('437b930db84b8079c2dd804a71936b5f')
  end
end

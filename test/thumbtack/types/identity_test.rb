# encoding: utf-8

require 'test_helper'

class IdentityTest < Minitest::Test
  def test_validate
    assert_equal Types::Identity, Types::Identity.validate('any value')
  end

  def test_serialize
    assert_equal 'any value', Types::Identity.serialize('any value')
  end

  def test_deserialize
    assert_equal 'any parameter',
                 Types::Identity.deserialize('any parameter')
  end
end

# encoding: utf-8

require 'test_helper'

class IdentityTest < Minitest::Test
  def test_validate
    assert_equal Types::Identity, Types::Identity.validate('any value')
  end

  def test_to_parameter
    assert_equal 'any value', Types::Identity.to_parameter('any value')
  end

  def test_from_parameter
    assert_equal 'any parameter',
      Types::Identity.from_parameter('any parameter')
  end
end

# typed: true
# frozen_string_literal: true

require "test_helper"

class SpecificationTest < Minitest::Test
  def test_parameters
    type_handler = Minitest::Mock.new
    type_handler.expect(:validate, type_handler, ["value"])
    type_handler.expect(:serialize, "parameterized", ["value"])

    assert_equal(
      {key: "parameterized"},
      Specification.new(key: type_handler).parameters(key: "value")
    )
    type_handler.verify
  end
end

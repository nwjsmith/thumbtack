# typed: true
# frozen_string_literal: true

require "test_helper"

class NoteSummaryTest < Minitest::Test
  def test_from_array
    array = [
      {"popular" => %w[ifttt]},
      {"recommended" => %w[ifttt twitter]}
    ]
    suggestion = Suggestion.from_array(array)

    assert_equal %w[ifttt], suggestion.popular
    assert_equal %w[ifttt twitter], suggestion.recommended
  end
end

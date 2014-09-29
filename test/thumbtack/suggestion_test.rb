# encoding: utf-8

require 'test_helper'

class NoteSummaryTest < Minitest::Test
  def test_from_array
    array = [
      { 'popular' => ['ifttt'] },
      { 'recommended' => ['ifttt', 'twitter'] }
    ]
    suggestion = Suggestion.from_array(array)

    assert_equal ['ifttt'], suggestion.popular
    assert_equal ['ifttt', 'twitter'], suggestion.recommended
  end
end

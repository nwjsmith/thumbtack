# frozen_string_literal: true

require 'test_helper'

class NoteSummaryTest < Minitest::Test
  def test_from_hash
    hash = {
      'id' => '8e5d6964bb810e0050b0',
      'title' => 'StarCraft beta coming this week!',
      'hash' => '0c9c30f60cadabd31415',
      'created_at' => '2010-02-11 03:46:56',
      'updated_at' => '2010-02-11 03:47:47',
      'length' => 19
    }
    note = NoteSummary.from_hash(hash)

    assert_equal '8e5d6964bb810e0050b0', note.id
    assert_equal 'StarCraft beta coming this week!', note.title
    assert_equal '0c9c30f60cadabd31415', note.digest
    assert_equal DateTime.new(2010, 2, 11, 3, 46, 56), note.created_at
    assert_equal DateTime.new(2010, 2, 11, 3, 47, 47), note.updated_at
    assert_equal 19, note.length
  end
end

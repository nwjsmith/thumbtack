# encoding: utf-8

require 'test_helper'

class NotesTest < Minitest::Test
  def test_list
    client = mock_client('/notes/list',
                         nil,
                         {
                           'count' => 2,
                           'notes' => [
                             {
                               'id' => 'cf73bfc02e00edaa1e2b',
                               'title' => 'Paul Graham on Hirin\' The Ladies',
                               'hash' => '0bbca3cba9246bbbda2c',
                               'created_at' => '2011-10-28 13:37:23',
                               'updated_at' => '2011-10-28 13:37:23',
                               'length' => '890',
                             },
                             {
                               'id' => '8e5d6964bb810e0050b0',
                               'title' => 'StarCraft beta coming this week!',
                               'hash' => '0c9c30f60cadabd31415',
                               'created_at' => '2010-02-11 03:46:56',
                               'updated_at' => '2010-02-11 03:47:47',
                               'length' => '153',
                             },
                           ]
                         })
    notes = Notes.new(client)
    result = notes.list

    assert_equal 2, result.length
    assert_equal 'cf73bfc02e00edaa1e2b', result[0].id
    assert_equal '8e5d6964bb810e0050b0', result[1].id
  end

  def test_get
    client = mock_client('/notes/8e5d6964bb810e0050b0',
                         nil,
                         {
                           'id' => '8e5d6964bb810e0050b0',
                           'title' => 'StarCraft beta coming this week!',
                           'text' => 'This is a test note',
                           'hash' => '0c9c30f60cadabd31415',
                           'created_at' => '2010-02-11 03:46:56',
                           'updated_at' => '2010-02-11 03:47:47',
                           'length' => 19
                         })
    notes = Notes.new(client)
    result = notes.get('8e5d6964bb810e0050b0')
    assert_equal '8e5d6964bb810e0050b0', result.id
    assert_equal 19, result.length
  end
end

# encoding: utf-8

require 'test_helper'

class TagsTest < Minitest::Test
  def mock_client(url, params, response)
    client = Minitest::Mock.new
    client.expect(:get, response, [url, params].compact)
    client
  end

  def test_update
    client = mock_client('/tags/get',
                         nil,
                         {
                           'activedesktop' => '1',
                           'business' => '1',
                           'radio' => '3',
                           'xml' => '5',
                           'xp' => '1',
                           'xpi' => '1',
                         })
    tags = Tags.new(client)

    assert_equal({
      'activedesktop' => 1,
      'business' => 1,
      'radio' => 3,
      'xml' => 5,
      'xp' => 1,
      'xpi' => 1,
    }, tags.get)

    client.verify
  end

  def test_delete
    client = mock_client('/tags/delete',
                         { tag: 'argentina' },
                         { 'result_code' => 'done' })
    tags = Tags.new(client)

    assert_equal tags, tags.delete('argentina')
    client.verify
  end
end

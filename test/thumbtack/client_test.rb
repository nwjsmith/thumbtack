# encoding: utf-8

require 'test_helper'

class ClientTest < Minitest::Test
  def setup
    @adapter = Minitest::Mock.new
    @client = Client.new(nil, nil, adapter: @adapter)
  end

  def test_posts
    assert_instance_of Posts, @client.posts
  end

  def test_tags
    assert_instance_of Tags, @client.tags
  end

  def test_user
    assert_instance_of User, @client.user
  end

  def test_notes
    assert_instance_of Notes, @client.notes
  end

  def test_default_adapter
    assert_kind_of Adapters::BasicAdapter, Client.new(nil, nil).adapter
  end

  def test_get
    @adapter.expect(:get,
                    {'posts' => []},
                    ['/posts/recent', {tag: 'thumbtack'}])
    @client.get('/posts/recent', tag: 'thumbtack')
    @adapter.verify
  end

  def test_action
    @adapter.expect(:get, { 'result' => 'done' }, ['/posts/update', {}])
    @client.action('/posts/update', {})
    @adapter.verify
  end

  def test_action_result_error
    assert_raises ResultError do
      @adapter.expect(:get, { 'result' => 'notdone' }, ['/posts/update', {}])
      @client.action('/posts/update', {})
    end
  end
end

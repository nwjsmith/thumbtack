# encoding: utf-8

require 'test_helper'

class ClientTest < Minitest::Test
  def setup
    @client = Client.new(username, token)
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
end

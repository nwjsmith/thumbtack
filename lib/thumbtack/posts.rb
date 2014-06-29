# encoding: utf-8

module Thumbtack
  # Internal: Wraps API calls related to posts
  class Posts
    # Internal: Creates a new Posts
    #
    # client - a Thumbtack::Client to communicate with the Pinboard API
    def initialize(client)
      @client = client
    end

    # Public: The most recent time a bookmark was added, updated, or deleted
    #
    # Example
    #
    #   update
    #   # => '2014-06-26T19:01:33Z'
    #
    # Returns a String containing timestamp in UTC
    def update
      response = @client.get('/posts/update')
      response.fetch('update_time')
    end

    # Public: Add a bookmark
    #
    # Example
    #
    #   add('http://theinternate.com', 'The Internate')
    #   add('http://theinternate.com', 'The Internate', tags: 'best ruby')
    #
    # Returns the Posts instance
    def add(url, description, params = {})
      required_params = { url: url, description: description }
      @client.get('/posts/add', required_params.merge(params))
      self
    end

    # Public: Delete a bookmark
    #
    # Example
    #
    #   delete('http://delicio.us')
    #
    # Returns the Posts instance
    def delete(url)
      @client.get('/posts/delete', url: url)
      self
    end
  end
end

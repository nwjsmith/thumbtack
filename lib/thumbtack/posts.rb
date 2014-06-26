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
  end
end

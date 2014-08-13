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
    # url - A String containing the URL to be bookmarked
    # description - A String containing the title of the bookmark
    # params - The Hash params to be passed as arguments
    #          :extended - A String containing a description of the item
    #          :tags - A String containing a list of up to 100 tags
    #          :dt - A String containing the creation time for this bookmark
    #          :replace - A String indicating whether or not to replace any
    #                     existing bookmark with this URL
    #          :shared - A String indicating whether or not to make the bookmark
    #                    public
    #          :toread - A String indicating whether or not to mark the bookmark
    #                    as unread
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
    # url - A String containing the URL of the bookmark to delete
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

    # Public: Return one or more posts matching the arguments
    #
    # params - The Hash params to be passed as arguments
    #          :tag - A String containing a list of up to three tags to filter
    #                 by
    #          :dt - A String containing the date when the results were
    #                bookmarked
    #          :url - A String containing the URL for the the bookmark
    #          :meta - A String indicating whether or not to include a change
    #                  detection signature
    #
    # Example
    #
    #   get(tag: 'webdev', meta: 'yes')
    #   get(url: 'http://www.pinboard.in')
    #
    # Returns a list of Post instances
    def get(params = {})
      response = @client.get('/posts/get', params)
      response.fetch('posts', []).map { |post_hash| Post.from_hash(post_hash) }
    end

    # Public: Return a list of the most recent posts
    #
    # params - The Hash params to be passed as arguments
    #          :tag - A String containing a list of up to three tags to filter
    #                 by
    #          :count - An Integer of the number of results to return. Default
    #                   is 15, maximum is 100.
    #
    # Example
    #
    #   recent(tag: 'webdev', count: 25)
    #
    # Returns a list of Post instances
    def recent(params = {})
      response = @client.get('/posts/recent', params)
      response.fetch('posts', []).map { |post_hash| Post.from_hash(post_hash) }
    end
  end
end

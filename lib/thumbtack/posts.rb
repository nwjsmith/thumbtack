# encoding: utf-8

module Thumbtack
  # Internal: Wraps API calls related to posts.
  class Posts
    # Internal: Initialize a Posts.
    #
    # client - A Thumbtack::Client to communicate with the Pinboard API.
    def initialize(client)
      @client = client
    end

    # Public: The most recent time a bookmark was added, updated, or deleted.
    #
    # Examples
    #
    #   update
    #   # => '2014-06-26T19:01:33Z'
    #
    # Returns a DateTime in UTC.
    def update
      response = @client.get('/posts/update')
      Types::DateTime.from_parameter response.fetch('update_time')
    end

    # Public: Add a bookmark.
    #
    # url - A String containing the URL to be bookmarked.
    # description - A String containing the title of the bookmark.
    # options - The Hash options to be passed as arguments.
    #           :extended - A String containing a description of the item.
    #           :tags     - An Array containing up to 100 tags.
    #           :dt       - A DateTime containing the creation time for this
    #                       bookmark.
    #           :replace  - A Boolean containing whether or not to replace any
    #                       existing bookmark with this URL.
    #           :shared   - A Boolean containing whether or not to make the
    #                       bookmark public.
    #           :toread   - A Boolean containing whether or not to mark the
    #                       bookmark as unread.
    #
    # Examples
    #
    #   add('http://theinternate.com', 'The Internate')
    #   add('http://theinternate.com', 'The Internate', tags: ['best', 'ruby'])
    #
    # Returns the Posts instance.
    def add(url, description, options = EMPTY_HASH)
      parameters = Specification.new(
        url: Types::URL,
        description: Types::Text,
        extended: Types::Text,
        tags: Types::Tags,
        dt: Types::DateTime,
        replace: Types::Boolean,
        shared: Types::Boolean,
        toread: Types::Boolean
      ).parameters({ url: url, description: description }.merge(options))
      @client.get('/posts/add', parameters)
      self
    end

    # Public: Delete a bookmark.
    #
    # url - A String containing the URL of the bookmark to delete.
    #
    # Examples
    #
    #   delete('http://delicio.us')
    #
    # Returns the Posts instance
    def delete(url)
      parameters = Specification.new(url: Types::URL).parameters(url: url)
      @client.get('/posts/delete', parameters)
      self
    end

    # Public: Return one or more posts matching the arguments.
    #
    # options - The Hash options to be passed as arguments.
    #          :tag  - An Array containing a up to three tags to filter by.
    #          :dt   - A DateTime containing the date when the results were
    #                  bookmarked.
    #          :url  - A String containing the URL for the the bookmark.
    #          :meta - A Boolean indicating whether or not to include a change
    #                  detection signature.
    #
    # Examples
    #
    #   get(tag: 'webdev', meta: 'yes')
    #   get(url: 'http://www.pinboard.in')
    #
    # Returns a list of Post instances.
    def get(options = EMPTY_HASH)
      parameters = Specification.new(
        tag: Types::Tags,
        dt: Types::DateTime,
        url: Types::URL,
        meta: Types::Boolean
      ).parameters(options)
      posts_from @client.get('/posts/get', parameters)
    end

    # Public: Return a list of the most recent posts.
    #
    # options - The Hash options to be passed as arguments.
    #          :tag   - An Array containing a up to three tags to filter by.
    #          :count - An Integer of the number of results to return. Default
    #                   is 15, maximum is 100.
    #
    # Examples
    #
    #   recent(tag: 'webdev', count: 25)
    #
    # Returns a list of Post instances.
    def recent(options = EMPTY_HASH)
      parameters = Specification.new(
        tag: Types::Tags,
        count: Types::Integer
      ).parameters(options)
      posts_from @client.get('/posts/recent', parameters)
    end

    # Public: Return all posts in the account.
    #
    # options - The Hash options to be passed as arguments.
    #          :tag     - A String containing a list of up to three tags to
    #                     filter by.
    #          :start   - An Integer offset value. Default is 0.
    #          :results - An Integer of the number of results to return.
    #          :fromdt  - Filter results to posts created after this DateTime.
    #          :todt    - Filter results to posts created before this DateTime.
    #          :meta    - A Boolean containing whether or not to include a
    #                     change detection signature.
    #
    # Returns a list of Posts instances
    def all(options = EMPTY_HASH)
      parameters = Specification.new(
        tag: Types::Tags,
        start: Types::Integer,
        results: Types::Integer,
        fromdt: Types::DateTime,
        todt: Types::DateTime,
        meta: Types::Boolean
      ).parameters(options)
      results = @client.get('/posts/all', parameters)
      results.map { |post_hash| Post.from_hash(post_hash) }
    end

    # Public: Return a list of popular and recommended tags for a URL.
    #
    # url - A String containing a URL to fetch suggested tags for.
    #
    # Returns a Hash with two entries, :popular is a list of popular tags,
    # :recommended is a list of recommended tags.
    def suggest(url)
      parameters = Specification.new(url: Types::URL).parameters(url: url)
      result = @client.get('/posts/suggest', parameters)
      { popular: result.fetch('popular'),
        recommended: result.fetch('recommended') }
    end

    # Public: Return a list dates with the count of posts made at each date.
    #
    # options - The Hash options to be passed as arguments
    #          :tag - An Array containing a up to three tags to filter by.
    #
    # Returns a Hash of Strings => Integer entries. The Strings contain a date
    # and the Integer is the count of posts made on that date.
    def dates(options = EMPTY_HASH)
      parameters = Specification.new(tag: Types::Tags).parameters(options)
      response = @client.get('/posts/dates', parameters)
      Hash[
        response.fetch('dates', {}).map do |date, count|
          [Types::Date.from_parameter(date), count.to_i]
        end
      ]
    end

    private

    def posts_from(response)
      response.fetch('posts', []).map { |post_hash| Post.from_hash(post_hash) }
    end
  end
end

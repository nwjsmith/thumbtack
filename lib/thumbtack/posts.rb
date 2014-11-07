# encoding: utf-8

module Thumbtack
  # Wraps API calls related to posts
  class Posts
    # Initialize a Posts
    #
    # @param [Client] client
    #   client to communicate with the Pinboard API
    #
    # @api private
    def initialize(client)
      @client = client
    end

    # Fetch the most recent time a bookmark was added, updated, or deleted
    #
    # @example
    #   update_time = posts.update
    #
    # @return [DateTime]
    #
    # @api public
    #
    # @see https://pinboard.in/api/#posts_update
    def update
      response = @client.get('/posts/update')
      Types::DateTime.from_parameter response.fetch('update_time')
    end

    # Add a bookmark
    #
    # @example
    #   posts.add(url, description, tags: ['one', 'two', 'three'])
    #
    # @param [String] url
    #   the URL of the bookmark
    # @param [String] description
    #   title of the bookmark
    # @param [Hash] options
    #   options for the bookmark addition
    # @option options [String] :extended
    #   a description of the bookmark
    # @option options [Array[String]] :tags
    #   a list of up to 100 tags
    # @option options [DateTime] :dt
    #   the creation time for this bookmark
    # @option options [Boolean] :replace
    #   if true, replace any existing bookmark with the same URL
    # @option options [Boolean] :shared
    #   if true, make the bookmark public
    # @option options [Boolean] :toread
    #   if true, mark the bookmark unread
    #
    # @return [self]
    #
    # @api public
    #
    # @see https://pinboard.in/api/#posts_add
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
      @client.action('/posts/add', parameters)
      self
    end

    # Delete a bookmark
    #
    # @example
    #   posts.delete(url)
    #
    # @param [String] url
    #   the URL of the bookmark to delete
    #
    # @return [self]
    #
    # @api public
    #
    # @see https://pinboard.in/api/#posts_delete
    def delete(url)
      parameters = Specification.new(url: Types::URL).parameters(url: url)
      @client.action('/posts/delete', parameters)
      self
    end

    # Fetch one or more bookmarks
    #
    # @example
    #   bookmarks = posts.get(tag: ['one', 'two', 'three'])
    #
    # @param [Hash] options
    #   options to filter the results by
    # @option options [Array<String>] :tag
    #   up to three tags to filter by
    # @option options [DateTime] :dt
    #   which day the results were bookmarked
    # @option options [String] :url
    #   the URL for this bookmark
    # @option options [Boolean] :meta
    #   if true, include the change detection signature in the results
    #
    # @return [Array<Post>]
    #
    # @api public
    #
    # @see https://pinboard.in/api/#posts_get
    def get(options = EMPTY_HASH)
      parameters = Specification.new(
        tag: Types::Tags,
        dt: Types::DateTime,
        url: Types::URL,
        meta: Types::Boolean
      ).parameters(options)
      posts_from @client.get('/posts/get', parameters)
    end

    # List the most recent bookmarks
    #
    # @example
    #   bookmarks = posts.recent(tag: ['one', 'two', 'three'], count: 25)
    #
    # @param [Hash] options
    #   options to filter the results by
    # @option options [Array<String>] :tag
    #   up to three tags to filter by
    # @option options [Integer] :count
    #   the number of results to return
    #
    # @return [Array<Post>]
    #
    # @api public
    #
    # @see https://pinboard.in/api/#posts_recent
    def recent(options = EMPTY_HASH)
      parameters = Specification.new(
        tag: Types::Tags,
        count: Types::Integer
      ).parameters(options)
      posts_from @client.get('/posts/recent', parameters)
    end

    # List all bookmarks
    #
    # @example
    #   posts.all(todt: yesterday, meta: true, tag: ['one', 'two', 'three'])
    #
    # @param [Hash] options
    #   options to filter the results by
    # @option options [Array<String>] :tag
    #   up to three tags to filter by
    # @option options [Array<String>] :start
    #   an offset value
    # @option options [Array<String>] :results
    #   number of results to return
    # @option options [DateTime] :fromdt
    #   limit results to those created after this time
    # @option options [DateTime] :todt
    #   limit results to those created before this time
    # @option options [Boolean] :meta
    #   if true, include the change detection signature in the results
    #
    # @return [Array<Post>]
    #
    # @api public
    #
    # @see https://pinboard.in/api/#posts_all
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

    # List popular and recommended tags for a URL
    #
    # @example
    #   suggestion = posts.suggest(url)
    #
    # @param [String] url
    #   URL to fetch suggested tags for
    #
    # Returns a Hash with two entries, :popular is a list of popular tags,
    # :recommended is a list of recommended tags.
    #
    # @return [Array<Suggestion>]
    #
    # @api public
    #
    # @see https://pinboard.in/api/#posts_suggest
    def suggest(url)
      parameters = Specification.new(url: Types::URL).parameters(url: url)
      Suggestion.from_array(@client.get('/posts/suggest', parameters))
    end

    # List dates with the number of bookmarks created on each
    #
    # @example
    #   dates = posts.dates(tag: ['one', 'two', 'three'])
    #
    # @param [Hash] options
    #   options to filter the results by
    # @option options [Array<String>] :tag
    #   up to three tags to filter by
    #
    # @return [Hash{Date => Integer}]
    #   dates on which bookmarks were created associated with the number of
    #   bookmarks created on that date
    #
    # @api public
    #
    # @see https://pinboard.in/api/#posts_dates
    def dates(options = EMPTY_HASH)
      parameters = Specification.new(tag: Types::Tags).parameters(options)
      response = @client.get('/posts/dates', parameters)
      dates_with_counts_from(response)
    end

    private

    # Create Post objects from posts response
    #
    # @return [Array<Post>]
    #
    # @api private
    def posts_from(response)
      response.fetch('posts', EMPTY_ARRAY).map do |post_hash|
        Post.from_hash(post_hash)
      end
    end

    # Create Hash of dates to counts from dates response
    #
    # @return [Hash{Date => Integer}]
    #
    # @api private
    def dates_with_counts_from(response)
      entries = response.fetch('dates', EMPTY_HASH).map do |date, count|
        [Types::Date.from_parameter(date), count.to_i]
      end
      Hash[entries]
    end
  end
end

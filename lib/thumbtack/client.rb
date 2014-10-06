# encoding: utf-8

module Thumbtack
  # Wraps each interaction with the Pinboard API
  class Client
    # Username used by the client to make authenticated requests
    #
    # @example
    #   client.username  # => 'maciej'
    #
    # @return [String]
    #
    # @api public
    attr_reader :username

    # Token used by the client to make authenticated requests
    #
    # @example
    #   client.token  # => 'C9044F4047891CEA74FE'
    #
    # @return [String]
    #
    # @api public
    attr_reader :token

    # Initialize a Client
    #
    # @example
    #   client = Client.new(username, token)
    #
    # @param [String] username
    #   the user to authenticate with
    # @param [String] token
    #   the API token for the user account, found on the Pinboard settings page
    #
    # @api public
    def initialize(username, token, options = EMPTY_HASH)
      @username, @token = username, token
      @adapter = options.fetch(:adapter) do
        Adapters::BasicAdapter.new(@username, @token)
      end
    end

    # Retrieve JSON from the Pinboard API
    #
    # @param [String] path
    #   the path to fetch from, relative to from the base Pinboard API URL
    #
    # @param [Hash] params
    #   query parameters to append to the URL
    #
    # @return [Hash] the response parsed from the JSON
    #
    # @raise [RateLimitError] if the response is rate-limited
    #
    # @api private
    def get(path, params = EMPTY_HASH)
      @adapter.get(path, params)
    end

    # Perform an action request against the Pinboard API
    #
    # @param [String] path
    #   the path to fetch from, relative to from the base Pinboard API URL
    #
    # @param [Hash] params
    #   query parameters to append to the URL
    #
    # @return [Hash] the response parsed from the JSON
    #
    # @raise [RateLimitError] if the response is rate-limited
    # @raise [ResultError] if the result code isn't "done"
    #
    # @api private
    # @see https://pinboard.in/api/#errors
    def action(path, params)
      response = @adapter.get(path, params)
      fail ResultError, response['result'] unless response['result'] == 'done'
      self
    end

    # Access posts-related API calls
    #
    # @example
    #   posts = client.posts
    #
    # @return [Posts]
    #
    # @api public
    def posts
      Posts.new(self)
    end

    # Access tags-related API calls
    #
    # @example
    #   tags = client.tags
    #
    # @return [Tags]
    #
    # @api public
    def tags
      Tags.new(self)
    end

    # Access user-related API calls
    #
    # @example
    #   user = client.user
    #
    # @return [User]
    #
    # @api public
    def user
      User.new(self)
    end

    # Access notes-related API calls
    #
    # @example
    #   notes = client.notes
    #
    # @return [Notes]
    #
    # @api public
    def notes
      Notes.new(self)
    end
  end
end

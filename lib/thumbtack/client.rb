# frozen_string_literal: true

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

    # Token used by the client to make authenticated requests
    #
    # @example
    #   client.adapter  # => #<Thumbtack::Adapters::BasicAdapter...
    #
    # @return [Adapter]
    #
    # @api public
    attr_reader :adapter

    # Initialize a Client
    #
    # @example
    #   client = Client.new(username, token)
    #
    # @param [String] username
    #   the user to authenticate with
    # @param [String] token
    #   the API token for the user account, found on the Pinboard settings page
    # @param [Hash] options
    #   options for the construction of the client
    # @option options [BasicAdapter] :adapter
    #   an adapter to use for communicating with the Pinboard API
    #
    # @api public
    def initialize(username, token, options = EMPTY_HASH)
      @username = username
      @token = token
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
      unless response['result_code'] == 'done'
        raise ResultError, response['result_code']
      end
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

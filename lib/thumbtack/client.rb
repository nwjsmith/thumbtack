# encoding: utf-8

module Thumbtack
  # Wraps each interaction with the Pinboard API
  class Client
    # The status code for rate limited responses from the Pinboard API
    TOO_MANY_REQUESTS_CODE = '429'.freeze

    # The base Pinboard API URL.
    BASE_URL = 'https://api.pinboard.in/v1'.freeze

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
    def initialize(username, token)
      @username, @token = username, token
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
      uri = URI("#{BASE_URL}#{path}")

      base_params = { auth_token: "#{@username}:#{@token}", format: 'json' }
      uri.query = URI.encode_www_form(params.merge(base_params))

      response = Net::HTTP.get_response(uri)
      fail RateLimitError if response.code == TOO_MANY_REQUESTS_CODE
      JSON.parse(response.body)
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
    def action(path, params = EMPTY_HASH)
      response = get(path, params)
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

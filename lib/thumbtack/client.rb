# encoding: utf-8

module Thumbtack
  # Public: Wraps each interaction with the Pinboard API.
  class Client
    # Internal: Raised when the API rate limit has been reached.
    class RateLimitError < StandardError; end

    # Internal: The status code of rate limited responses from the Pinboard API.
    TOO_MANY_REQUESTS_CODE = '429'.freeze

    # Public: String of base Pinboard API URL.
    BASE_URL = 'https://api.pinboard.in/v1'.freeze

    # Public: Returns the String username being used by the client.
    attr_reader :username

    # Public: Returns the String API token being used by the client.
    attr_reader :token

    # Public: Creates a new client.
    #
    # username - A String naming the user account to authenticate with.
    # token - A String of the API token for the user account. Can be found on
    #         the user's settings page.
    def initialize(username, token)
      @username, @token = username, token
    end

    # Internal: Request JSON from the Pinboard API.
    #
    # path - A String of the path to fetch from. The is relative from the root
    #        Pinboard API URL.
    # params - A Hash of query parameters to append to the URL for the fetch
    #          (default: {}).
    #
    # Examples
    #
    #   get('/posts/update')
    #   # => {'update_time' => '2014-06-24T15:39:46Z'}
    #
    #   get('/posts/suggest', url: 'http://theinternate.com/')
    #   # => [{'popular' => []}, {'recommended' => []}]
    #
    # Returns a parsed JSON response from Pinboard's API.
    def get(path, params = {})
      uri = URI("#{BASE_URL}#{path}")

      base_params = { auth_token: "#{@username}:#{@token}", format: 'json' }
      uri.query = URI.encode_www_form(params.merge(base_params))

      response = Net::HTTP.get_response(uri)
      fail Client::RateLimitError if response.code == TOO_MANY_REQUESTS_CODE
      JSON.parse(response.body)
    end

    # Public: Access posts-related API calls.
    def posts
      Posts.new(self)
    end

    # Public: Access tags-related API calls.
    def tags
      Tags.new(self)
    end

    # Public: Access user-related API calls.
    def user
      User.new(self)
    end

    # Public: Access notes-related API calls.
    def notes
      Notes.new(self)
    end
  end
end

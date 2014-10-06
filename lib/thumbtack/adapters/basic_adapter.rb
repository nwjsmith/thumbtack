# encoding: utf-8

module Thumbtack
  module Adapters
    # A basic adapter using Ruby's builtin HTTP and JSON parsing libraries
    class BasicAdapter
      # The status code for rate limited responses from the Pinboard API
      TOO_MANY_REQUESTS_CODE = '429'.freeze

      # The base Pinboard API URL.
      BASE_URL = 'https://api.pinboard.in/v1'.freeze

      # Initialize a BasicAdapter
      #
      # @example
      #   client = BasicAdapter.new(username, token)
      #
      # @param [String] username
      #   the user to authenticate with
      # @param [String] token
      #   the API token for the user, found on the Pinboard settings page
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
    end
  end
end

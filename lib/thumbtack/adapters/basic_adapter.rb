# encoding: utf-8

module Thumbtack
  module Adapters
    # A basic adapter using Ruby's builtin HTTP and JSON parsing libraries
    class BasicAdapter
      # The status code for rate limited responses from the Pinboard API
      TOO_MANY_REQUESTS_CODE = '429'.freeze

      # The response format requested from the Pinboard API
      RESPONSE_FORMAT = 'json'.freeze

      # The base Pinboard API URL.
      BASE_URL = 'https://api.pinboard.in/v1'.freeze

      # A secure version of SSL
      SSL_VERSION = 'TLSv1_2'.freeze

      # Secure cipher list
      SSL_CIPHERS = 'TLSv1.2:!aNULL:!eNULL'.freeze

      # Initialize a BasicAdapter
      #
      # @example
      #   adapter = BasicAdapter.new(username, token)
      #
      # @param [String] username
      #   the user to authenticate with
      # @param [String] token
      #   the API token for the user, found on the Pinboard settings page
      #
      # @api public
      def initialize(username, token)
        @username = username
        @token = token
      end

      # Retrieve JSON from the Pinboard API
      #
      # @param [String] path
      #   the path to fetch from, relative to the base Pinboard API URL
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
        uri.query = extend_parameters(params)
        JSON.parse(http_response(uri).body)
      end

      private

      # Retrieve HTTP response from a URI
      #
      # @param [URI] uri
      #   the uri to fetch from
      # @return [Net::HTTPResponse]
      #   the response
      #
      # @api private
      # @raise [RateLimitError] if the response is rate-limited
      def http_response(uri)
        request = Net::HTTP::Get.new(uri)
        connection(uri.host, uri.port).request(request).tap do |response|
          fail RateLimitError if response.code == TOO_MANY_REQUESTS_CODE
        end
      end

      # Construct a secure HTTP connection to the Pinboard API
      #
      # @param [String] host
      #   the Pinboard API host
      # @param [Fixnum] port
      #   the Pinboard API port
      # @return [Net::HTTP]
      #   the connection
      #
      # @api private
      def connection(host, port)
        Net::HTTP.new(host, port).tap do |connection|
          connection.use_ssl = true
          connection.ssl_version = SSL_VERSION
          connection.ciphers = SSL_CIPHERS
        end
      end

      # Extend parameters with authentication and format parameters
      #
      # @param [Hash{#to_s => #to_s}] parameters
      #   the parameters to extend
      # @return [Hash{#to_s => #to_s}]
      #   the extended parameters
      #
      # @api private
      def extend_parameters(parameters)
        base_params = { auth_token: "#{@username}:#{@token}",
                        format: RESPONSE_FORMAT }
        URI.encode_www_form(parameters.merge(base_params))
      end
    end
  end
end

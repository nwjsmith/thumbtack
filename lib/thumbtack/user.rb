# encoding: utf-8

module Thumbtack
  # Wraps API calls related to users
  class User
    # Initialize a User
    #
    # @param [Client] client
    #   client to communicate with the Pinboard API
    #
    # @api private
    def initialize(client)
      @client = client
    end

    # Fetch the secret RSS key for viewing private feeds
    #
    # @example
    #   rss_key = user.secret
    #
    # @return [String]
    #
    # @api public
    #
    # @see https://pinboard.in/api/#user_secret
    def secret
      @client.get('/user/secret').fetch('result')
    end

    # Fetch the API token for making calls without a password
    #
    # @example
    #   api_token = user.api_token
    #
    # @return [String]
    #
    # @api public
    #
    # @see https://pinboard.in/api/#user_api_token
    def api_token
      @client.get('/user/api_token').fetch('result')
    end
  end
end

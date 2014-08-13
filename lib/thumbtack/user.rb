# encoding: utf-8

module Thumbtack
  # Internal: Wraps API calls related to users
  class User
    # Internal: Creates a new User
    #
    # client - a Thumbtack::Client to communicate with the Pinboard API.
    def initialize(client)
      @client = client
    end

    # Public: Returns the user's secret RSS key for viewing private feeds
    def secret
      @client.get('/user/secret').fetch('result')
    end

    # Public: Returns the user's API token for making calls without a password
    def api_token
      @client.get('/user/api_token').fetch('result')
    end
  end
end

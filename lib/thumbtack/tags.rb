# encoding: utf-8

module Thumbtack
  # Internal: Wraps API calls related to tags
  class Tags
    # Internal: Creates a new Tags
    #
    # client - a Thumbtack::Client to communicate with the Pinboard API.
    def initialize(client)
      @client = client
    end

    # Public: Returns a list of the user's tags with their counts
    def get
      response = @client.get('/tags/get')
      Hash[response.map { |tag, count| [tag, count.to_i] }]
    end

    # Public: Delete a tag
    #
    # tag - A String containing the tag to delete.
    #
    # Returns the Tags instance
    def delete(tag)
      @client.get('/tags/delete', tag: tag)
      self
    end
  end
end

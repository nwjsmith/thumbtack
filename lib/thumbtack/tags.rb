# encoding: utf-8

module Thumbtack
  # Internal: Wraps API calls related to tags.
  class Tags
    # Internal: Creates a new Tags.
    #
    # client - a Thumbtack::Client to communicate with the Pinboard API.
    def initialize(client)
      @client = client
    end

    # Public: Returns a list of the user's tags with their counts.
    def get
      response = @client.get('/tags/get')
      Hash[response.map { |tag, count| [tag, count.to_i] }]
    end

    # Public: Delete a tag.
    #
    # tag - A String containing the tag to delete.
    #
    # Returns the Tags instance.
    def delete(tag)
      parameters = Specification.new(tag: Types::Tags).parameters(tag: tag)
      @client.get('/tags/delete', parameters)
      self
    end

    # Public: Rename a tag.
    #
    # old - A String containing the tag to be renamed.
    # new - A String containing the new name for the tag.
    #
    # Returns the Tags instance.
    def rename(old, new)
      parameters = Specification.new(
        old: Types::Tags,
        new: Types::Tags
      ).parameters(old: old, new: new)
      @client.get('/tags/rename', parameters)
      self
    end
  end
end

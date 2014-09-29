# encoding: utf-8

module Thumbtack
  # Wraps API calls related to tags
  class Tags
    # Initialize a Tags
    #
    # @param [Client] client
    #   client to communicate with the Pinboard API
    #
    # @api private
    def initialize(client)
      @client = client
    end

    # List tags with their counts
    #
    # @return [Hash<String => Integer>]
    #   tags associated with the number of times they have been used
    #
    # @api public
    def get
      response = @client.get('/tags/get')
      Hash[response.map { |tag, count| [tag, count.to_i] }]
    end

    # Delete a tag
    #
    # @param [String] tag
    #   the tag to delete
    #
    # @return [self]
    #
    # @api public
    def delete(tag)
      parameters = Specification.new(tag: Types::Tags).parameters(tag: tag)
      @client.get('/tags/delete', parameters)
      self
    end

    # Rename a tag
    #
    # @param [String] old
    #   the tag to be renamed
    # @param [String] new
    #   the new name for the tag
    #
    # @return [self]
    #
    # @api public
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

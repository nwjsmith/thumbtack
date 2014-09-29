# encoding: utf-8

module Thumbtack
  # Wraps API calls related to notes
  class Notes
    # Initialize a Notes
    #
    # @param [Client] client
    #   client to communicate with the Pinboard API
    #
    # @api private
    def initialize(client)
      @client = client
    end

    # List of summaries of the user's notes
    #
    # @return [Array<NoteSummary>]
    #
    # @api public
    def list
      response = @client.get('/notes/list')
      response.fetch('notes', []).map do |note_hash|
        NoteSummary.from_hash(note_hash)
      end
    end

    # Fetch a note
    #
    # @param [#to_s] id
    #   the id of the note to fetch
    #
    # @return [Note]
    #
    # @api public
    def get(id)
      Note.from_hash @client.get("/notes/#{id}")
    end
  end
end

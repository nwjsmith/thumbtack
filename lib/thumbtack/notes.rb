# frozen_string_literal: true

module Thumbtack
  # Wraps API calls related to notes
  class Notes
    attr_reader :client

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
    # @example
    #   summaries = notes.list
    #
    # @return [Array<NoteSummary>]
    #
    # @api public
    #
    # @see https://pinboard.in/api/#notes_list
    def list
      response = client.get('/notes/list')
      response.fetch('notes', EMPTY_ARRAY).map do |note_hash|
        NoteSummary.from_hash(note_hash)
      end
    end

    # Fetch a note
    #
    # @example
    #   note = notes.get(id)
    #
    # @param [#to_s] id
    #   the id of the note to fetch
    #
    # @return [Note]
    #
    # @api public
    #
    # @see https://pinboard.in/api/#notes_id
    def get(id)
      Note.from_hash client.get("/notes/#{id}")
    end
  end
end

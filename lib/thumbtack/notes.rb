# encoding: utf-8

module Thumbtack
  # Internal: Wraps API calls related to notes
  class Notes
    # Internal: Creates a new Notes
    #
    # client - a Thumbtack::Client to communicate with the Pinboard API.
    def initialize(client)
      @client = client
    end

    # Public: Returns a list of summaries of the user's notes
    def list
      response = @client.get('/notes/list')
      response.fetch('notes', []).map do |note_hash|
        NoteSummary.from_hash(note_hash)
      end
    end

    # Public: Return an individual note
    def get(id)
      Note.from_hash @client.get("/notes/#{id}")
    end
  end
end

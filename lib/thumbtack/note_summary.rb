# encoding: utf-8

module Thumbtack
  # Public: Represents a note summary as returned from Notes#list.
  class NoteSummary
    # Private: The attributes for a NoteSummary.
    ATTRIBUTES = [
      :id,
      :title,
      :hash,
      :created_at,
      :updated_at,
      :length
    ].freeze

    attr_reader(*ATTRIBUTES)

    # Internal: Creates a new NoteSummary from a Hash, usually a Client#get
    # response.
    #
    # hash - A Hash of attributes of the note.
    def self.from_hash(hash)
      new(Hash[hash.map { |key, value| [key.to_sym, value] }])
    end

    # Internal: Initialize a NoteSummary.
    #
    # attrs - A Hash of attributes of the NoteSummary.
    def initialize(attrs = EMPTY_HASH)
      ATTRIBUTES.each do |attribute|
        instance_variable_set "@#{attribute}", attrs.fetch(attribute)
      end
    end
  end
end

# encoding: utf-8

module Thumbtack
  # Public: Represents a note.
  class Note
    # Private: The attributes for a Note.
    ATTRIBUTES = [
      :id,
      :title,
      :created_at,
      :updated_at,
      :digest,
      :text,
      :length
    ].freeze

    attr_reader(*ATTRIBUTES)

    # Internal: Creates a new Note from a Hash, usually a Client#get response.
    #
    # hash - A Hash of attributes of the note.
    def self.from_hash(hash)
      attrs = hash.dup
      digest = attrs.delete('hash')
      new(Hash[attrs.map { |k, v| [k.to_sym, v] }].merge(digest: digest))
    end

    # Internal: Initialize a Note.
    #
    # attrs - A Hash of attributes of the Note.
    def initialize(attrs = EMPTY_HASH)
      ATTRIBUTES.each do |attribute|
        instance_variable_set "@#{attribute}", attrs.fetch(attribute)
      end
    end
  end
end

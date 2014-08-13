# encoding: utf-8

module Thumbtack
  # Public: Represents a note
  class Note
    ATTRIBUTES = [
      :id,
      :title,
      :hash,
      :created_at,
      :updated_at,
      :text,
      :length
    ].freeze

    attr_reader(*ATTRIBUTES)

    # Internal: Creates a new Note from a Hash, usually a `Client#get` response.
    #
    # hash - A Hash of attributes of the note
    def self.from_hash(hash)
      new(Hash[hash.map { |key, value| [key.to_sym, value] }])
    end

    def initialize(attrs = {})
      ATTRIBUTES.each do |attribute|
        instance_variable_set "@#{attribute}", attrs.fetch(attribute)
      end
    end

    def digest
      @hash
    end
  end
end

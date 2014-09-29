# encoding: utf-8

module Thumbtack
  # Represents a note
  #
  # @api public
  class Note
    # The attributes for a Note
    #
    # @api private
    ATTRIBUTES = [
      :id,
      :title,
      :created_at,
      :updated_at,
      :digest,
      :text,
      :length
    ].freeze

    # The identifier for the note
    #
    # @return [String]
    #
    # @api public
    attr_reader :id

    # The title of the note
    #
    # @return [String]
    #
    # @api public
    attr_reader :title

    # The time at which the note was created
    #
    # @return [String]
    #
    # @api public
    attr_reader :created_at

    # The time at which the note was last updated
    #
    # @return [String]
    #
    # @api public
    attr_reader :updated_at

    # 20 character hexadecimal SHA1 hash of the note text
    #
    # @return [String]
    #
    # @api public
    attr_reader :digest

    # The text of the note
    #
    # @return [String]
    #
    # @api public
    attr_reader :text

    # The length of the note text
    #
    # @return [Integer]
    #
    # @api public
    attr_reader :length

    # Creates a new Note from a Hash
    #
    # @param [Hash{#to_sym => Object}] hash
    #   Note attributes
    #
    # @return [Note]
    #
    # @api private
    # @see Client#get
    def self.from_hash(hash)
      attrs = hash.dup
      digest = attrs.delete('hash')
      new(Hash[attrs.map { |k, v| [k.to_sym, v] }].merge(digest: digest))
    end

    # Initialize a Note
    #
    # @param [Hash] attrs
    #   Note attributes
    #
    # @api private
    def initialize(attrs = EMPTY_HASH)
      ATTRIBUTES.each do |attribute|
        instance_variable_set "@#{attribute}", attrs.fetch(attribute)
      end
    end
  end
end

# frozen_string_literal: true

module Thumbtack
  # Represents a note summary as returned from Notes#list.
  #
  # @api public
  # @see Notes#list
  class NoteSummary
    # The attributes for a NoteSummary
    #
    # @api private
    ATTRIBUTES = %i[
      id
      title
      digest
      created_at
      updated_at
      length
    ].freeze

    # The identifier for the note
    #
    # @example
    #   note.id  # => '8e5d6964bb810e0050b0'
    #
    # @return [String]
    #
    # @api public
    attr_reader :id

    # The title of the note
    #
    # @example
    #   note.title  # => 'StarCraft beta coming this week!'
    #
    # @return [String]
    #
    # @api public
    attr_reader :title

    # The time at which the note was created
    #
    # @example
    #   note.created_at  # => #<DateTime: 2014-08-13T19:53:16+00:00...
    #
    # @return [DateTime]
    #
    # @api public
    def created_at
      Types::DateTime.deserialize_from_note(@created_at)
    end

    # The time at which the note was last updated
    #
    # @example
    #   note.updated_at  # => #<DateTime: 2014-08-13T19:53:16+00:00...
    #
    # @return [DateTime]
    #
    # @api public
    def updated_at
      Types::DateTime.deserialize_from_note(@updated_at)
    end

    # 20 character hexadecimal SHA1 hash of the note text
    #
    # @example
    #   note.digest  # => '0c9c30f60cadabd31415'
    #
    # @return [String]
    #
    # @api public
    attr_reader :digest

    # The length of the note text
    #
    # @example
    #   note.length  # => 153
    #
    # @return [Integer]
    #
    # @api public
    attr_reader :length

    # Creates a new NoteSummary from a Hash
    #
    # @param [Hash{#to_sym => Object}] hash
    #   NoteSummary attributes
    #
    # @return [NoteSummary]
    #
    # @api private
    # @see Client#get
    def self.from_hash(hash)
      new(SymbolizeKeys.symbolize(HashToDigest.rename(hash)))
    end

    # Initialize a NoteSummary
    #
    # @param [Hash] attrs
    #   NoteSummary attributes
    #
    # @api private
    def initialize(attrs = EMPTY_HASH)
      ATTRIBUTES.each do |attribute|
        instance_variable_set "@#{attribute}", attrs.fetch(attribute)
      end
    end
  end
end

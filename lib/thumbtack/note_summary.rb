# encoding: utf-8

module Thumbtack
  # Represents a note summary as returned from Notes#list.
  #
  # @api public
  # @see Notes#list
  class NoteSummary
    # The attributes for a NoteSummary
    #
    # @api private
    ATTRIBUTES = [
      :id,
      :title,
      :digest,
      :created_at,
      :updated_at,
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

    # The length of the note text
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
      attrs = hash.dup
      digest = attrs.delete('hash')
      new(Hash[attrs.map { |k, v| [k.to_sym, v] }].merge(digest: digest))
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

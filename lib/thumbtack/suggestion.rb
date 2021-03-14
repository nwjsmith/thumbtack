# frozen_string_literal: true

module Thumbtack
  # Represents a suggestion
  #
  # @api public
  class Suggestion
    # The key associated with popular tags
    #
    # @api private
    POPULAR_KEY = "popular"

    # The key associated with suggested tags
    #
    # @api private
    RECOMMENDED_KEY = "recommended"

    # A list of popular tags for URL
    #
    # @example
    #   suggestion.popular  # => ['blog', 'blogs', 'people']
    #
    # @return [Array<String>]
    #
    # @api public
    attr_reader :popular

    # A list of recommended tags for the URL
    #
    # @example
    #   suggestion.recommended  # => ['blog', 'blogs', 'writing'...
    #
    # @return [Array<String>]
    #
    # @api public
    attr_reader :recommended

    # Initialize a Suggestion
    #
    # @param [Hash] attrs
    #   Suggestion attributes
    #
    # @api private
    def initialize(attrs = EMPTY_HASH)
      @popular = attrs.fetch(:popular)
      @recommended = attrs.fetch(:recommended)
    end

    # Creates a new Suggestions from an Array of Hashes
    #
    # @param [Array<Hash{String => Array<String>}>] array
    #   Suggestions attributes
    #
    # @return [Suggestion]
    #
    # @api private
    # @see Client#get
    def self.from_array(array)
      new(popular: entries_for(POPULAR_KEY, array),
          recommended: entries_for(RECOMMENDED_KEY, array))
    end

    # Extracts the entries for a given key in an array of hashes
    #
    # @param [String] key
    #   A key from which to extract the entries
    #
    # @param [Array<Hash{String => Array<String>}>] array
    #   An array of strings associated with the key
    #
    # @return [Array[String]]
    #
    # @api private
    def self.entries_for(key, array)
      array.find { |hash| hash.key?(key) }.fetch(key, EMPTY_ARRAY)
    end
    private_class_method :entries_for
  end
end

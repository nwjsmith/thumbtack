# encoding: utf-8

module Thumbtack
  # Represents a suggestion
  #
  # @api public
  class Suggestion
    # The key associated with popular tags
    #
    # @api private
    POPULAR_KEY = 'popular'.freeze

    # The key associated with suggested tags
    #
    # @api private
    RECOMMENDED_KEY = 'recommended'.freeze

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
      popular = array.find { |hash| hash.key?(POPULAR_KEY) }
      recommended = array.find { |hash| hash.key?(RECOMMENDED_KEY) }
      new(popular: popular.fetch(POPULAR_KEY, EMPTY_ARRAY),
          recommended: recommended.fetch(RECOMMENDED_KEY, EMPTY_ARRAY))
    end
  end
end

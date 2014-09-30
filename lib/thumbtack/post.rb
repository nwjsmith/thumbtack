# encoding: utf-8

module Thumbtack
  # Represents a bookmark
  #
  # @api public
  class Post
    # The attributes for a Post
    #
    # @api private
    ATTRIBUTES = [
      :href,
      :description,
      :extended,
      :meta,
      :hash,
      :time,
      :shared,
      :toread,
      :tags
    ].freeze

    # The url of the post
    #
    # @return [String]
    #
    # @api public
    attr_reader :href

    # The title of the post
    #
    # @return [String]
    #
    # @api public
    attr_reader :description

    # The description of the post
    #
    # @return [String]
    #
    # @api public
    attr_reader :extended

    # 32 character hexadecimal MD5 hash tag 'version' of the post
    #
    # @return [String]
    #
    # @api public
    attr_reader :meta

    # 32 character hexadecimal MD5 hash of the post URL
    #
    # @return [String]
    #
    # @api public
    attr_reader :hash

    # The time at which the post was created
    #
    # @return [DateTime]
    #
    # @api public
    def time
      Types::DateTime.from_parameter(@time)
    end

    # If true, this post is public
    #
    # @return [Boolean]
    #
    # @api public
    def shared
      Types::Boolean.from_parameter(@shared)
    end

    # If true, this post is marked unread
    #
    # @return [Boolean]
    #
    # @api public
    def toread
      Types::Boolean.from_parameter(@toread)
    end

    # The tags for this post, space-seperated
    #
    # @return [Array<String>]
    #
    # @api public
    def tags
      Types::Tags.from_parameter(@tags)
    end

    # Creates a new Post from a Hash
    #
    # @param [Hash{#to_sym => Object}] hash
    #   Post attributes
    #
    # @return [Post]
    #
    # @api private
    # @see Client#get
    def self.from_hash(hash)
      new(Hash[hash.map { |key, value| [key.to_sym, value] }])
    end

    # Initialize a Post
    #
    # @param [Hash] attrs
    #   Post attributes
    #
    # @api private
    def initialize(attrs = EMPTY_HASH)
      ATTRIBUTES.each do |attribute|
        instance_variable_set "@#{attribute}", attrs.fetch(attribute)
      end
    end
  end
end

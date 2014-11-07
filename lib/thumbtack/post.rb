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
      :digest,
      :time,
      :shared,
      :toread,
      :tags
    ].freeze

    # The url of the post
    #
    # @example
    #   post.href  # => 'http://pinboard.in'
    #
    # @return [String]
    #
    # @api public
    attr_reader :href

    # The title of the post
    #
    # @example
    #   post.description  # => 'Pinboard'
    #
    # @return [String]
    #
    # @api public
    attr_reader :description

    # The description of the post
    #
    # @example
    #   post.extended  # => 'antisocial bookmarking'
    #
    # @return [String]
    #
    # @api public
    attr_reader :extended

    # 32 character hexadecimal MD5 hash change signature for the post
    #
    # @example
    #   post.meta  # => '92959a96fd69146c5fe7cbde6e5720f2'
    #
    # @return [String]
    #
    # @api public
    attr_reader :meta

    # 32 character hexadecimal MD5 hash of the post URL
    #
    # @example
    #   post.digest  # => '92959a96fd69146c5fe7cbde6e5720f2'
    #
    # @return [String]
    #
    # @api public
    attr_reader :digest

    # The time at which the post was created
    #
    # @example
    #   post.time  # => #<DateTime: 2014-09-17T13:45:27+00:00...
    #
    # @return [DateTime]
    #
    # @api public
    def time
      Types::DateTime.from_parameter(@time)
    end

    # If true, this post is public
    #
    # @example
    #   post.shared  # => true
    #
    # @return [Boolean]
    #
    # @api public
    def shared
      Types::Boolean.from_parameter(@shared)
    end

    # If true, this post is marked unread
    #
    # @example
    #   post.toread  # => false
    #
    # @return [Boolean]
    #
    # @api public
    def toread
      Types::Boolean.from_parameter(@toread)
    end

    # The tags for this post, space-seperated
    #
    # @example
    #   post.tags  # => ['bookmarks', 'tools']
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
      new(SymbolizeKeys.symbolize(HashToDigest.rename(hash)))
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

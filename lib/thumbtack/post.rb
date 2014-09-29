# encoding: utf-8

module Thumbtack
  # Public: Represents a bookmark.
  class Post
    # Private: The attributes for a Post.
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

    attr_reader(*ATTRIBUTES)

    # Internal: Creates a new post from a Hash, usually a Client#get response.
    #
    # hash - A Hash of attributes of the Post.
    def self.from_hash(hash)
      new(Hash[hash.map { |key, value| [key.to_sym, value] }])
    end

    # Internal: Initialize a Post.
    #
    # attrs - A Hash of attributes of the Post.
    def initialize(attrs = EMPTY_HASH)
      ATTRIBUTES.each do |attribute|
        instance_variable_set "@#{attribute}", attrs.fetch(attribute)
      end
    end
  end
end

# typed: true
# frozen_string_literal: true

module Thumbtack
  # Handles renaming the hash attribute to digest from response hashes. This is
  # required in order to avoid collisions with the `Object#hash` method.
  #
  # @api private
  class HashToDigest
    HASH = "hash"
    DIGEST = "digest"

    # Rename any attribute called hash to digest
    #
    # @example
    #   HashToDigest.rename('hash' => '1234')  # => { 'digest' => '1234' }
    #
    # @param [Hash{String => Object}] hash
    #   the response hash
    #
    # @return [Hash{String => Object}]
    #   a hash with any key 'hash' renamed to 'digest'
    def self.rename(hash)
      attrs = hash.dup
      digest = attrs.delete(HASH)
      attrs.merge(DIGEST => digest)
    end
  end
end

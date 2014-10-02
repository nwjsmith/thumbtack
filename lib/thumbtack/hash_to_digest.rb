module Thumbtack
  # Handles renaming the hash attribute to digest from response hashes.
  #
  # @api private
  class HashToDigest
    # Rename any attribute called hash to digest
    #
    # @example
    #   HashToDigest.rename('hash' => '1234')  # => { :digest => '1234' }
    #
    # @param [Hash{String => Object}]
    #   reponse hash
    #
    # @return [Hash{Symbol => Object}]
    #   a hash with any key named hash renamed to digest
    def self.rename(hash)
      attrs = hash.dup
      digest = attrs.delete('hash')
      Hash[attrs.map { |k, v| [k.to_sym, v] }].merge(digest: digest)
    end
  end
end

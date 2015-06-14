# encoding: utf-8

module Thumbtack
  # Handles converting string keys to symbols in a response hash
  #
  # @api private
  class SymbolizeKeys
    # Convert any keys to symbols
    #
    # @example
    #   SymbolizeKeys.symbolize('digest' => '1234')  # => { :digest => '1234' }
    #
    # @param [Hash{#to_sym => Object}] hash
    #   the response hash
    #
    # @return [Hash{Symbol => Object}]
    #   a hash with symbol keys
    def self.symbolize(hash)
      Hash[hash.map { |key, value| [key.to_sym, value] }]
    end
  end
end

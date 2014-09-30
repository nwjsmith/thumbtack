# encoding: utf-8

module Thumbtack
  module Types
    # Handles validation of Integer types as the values supported by Pinboard
    #
    # @api private
    class Integer < Identity
      # The minimum allowable integer
      MIN = 0
      # The maximum allowable integer
      MAX = 2**32

      # Validate something is a valid integer parameter
      #
      # @param [Integer] value
      #   the integer to validate
      #
      # @return [undefined]
      #
      # @raise [Types::ValidationError]
      #   if the value is not between 0 and 2^32
      def self.validate(value)
        RangeValidation.validate value, MIN..MAX
        self
      end
    end
  end
end

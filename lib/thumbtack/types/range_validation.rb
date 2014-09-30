module Thumbtack
  module Types
    # Handles validation of values within a certain range
    # Pinboard
    #
    # @api private
    class RangeValidation
      # Validate a value
      #
      # @example
      #   RangeValidation.validate((1..2), 3)  # => ValidationError raised
      #
      # @param [Object] value
      #   the value to validate
      # @param [Range] range
      #   the range of valid values
      #
      # @return [undefined]
      #
      # @raise [Types::ValidationError]
      #   if the value is not between 0001-01-01 and 2100-01-01
      def self.validate(value, range)
        unless range.cover?(value)
          fail ValidationError,
               "#{value} must be between #{range.begin} and #{range.end}"
        end
      end
    end
  end
end

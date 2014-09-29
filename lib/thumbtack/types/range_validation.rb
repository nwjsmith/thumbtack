module Thumbtack
  module Types
    # Handles validation of values within a certain range
    # Pinboard
    #
    # @api private
    class RangeValidation
      # Validate a value
      #
      # @param [Object] low
      #   the lowest possible value
      # @param [Object] low
      #   the highest possible value
      # @param [Object] value
      #   the value to validate
      #
      # @return [undefined]
      #
      # @raise [Types::ValidationError]
      #   if the value is not between 0001-01-01 and 2100-01-01
      def self.validate(range, value)
        unless range.cover?(value)
          fail ValidationError,
            "#{value} must be between #{range.begin} and #{range.end}"
        end
      end
    end
  end
end

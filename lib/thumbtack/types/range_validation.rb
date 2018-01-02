# frozen_string_literal: true

module Thumbtack
  module Types
    # Handles validation of values within a certain range
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
      # @return [self]
      #
      # @raise [Types::ValidationError]
      #   if the value is not within the range
      def self.validate(value, range)
        unless range.cover?(value)
          raise ValidationError,
                "#{value} must be between #{range.begin} and #{range.end}"
        end
        self
      end
    end
  end
end

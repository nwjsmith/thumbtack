# typed: true
# frozen_string_literal: true

module Thumbtack
  module Types
    # Handles validation of the length of values
    #
    # @api private
    class LengthValidation
      # Validate a value
      #
      # @param [Object] maximum_length
      #   the maximum length
      # @param [Object] value
      #   the value to validate
      #
      # @return [self]
      #
      # @raise [Types::ValidationError]
      #   if the value is not less or equal to the maximum length
      def self.validate(value, maximum_length)
        unless value.length <= maximum_length
          raise ValidationError,
            "#{value} cannot be greater than #{maximum_length} characters"
        end
        self
      end
    end
  end
end

module Thumbtack
  module Types
    # Handles validation of values within a certain range
    # Pinboard
    #
    # @api private
    class LengthValidation
      # Validate a value
      #
      # @param [Object] length
      #   the maximum length
      # @param [Object] value
      #   the value to validate
      #
      # @return [undefined]
      #
      # @raise [Types::ValidationError]
      #   if the value is not between 0001-01-01 and 2100-01-01
      def self.validate(value, length)
        unless value.length <= length
          fail ValidationError,
               "#{value} cannot be greater than #{length} characters"
        end
      end
    end
  end
end

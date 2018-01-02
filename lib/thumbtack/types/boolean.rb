# frozen_string_literal: true

module Thumbtack
  module Types
    # Handles conversion and validation of Booleans to the 'yes'
    # and 'no' parameters supported by Pinboard
    #
    # @api private
    class Boolean
      # Validate a value is a boolean parameter
      #
      # @param [Boolean] value
      #   the value to validate
      #
      # @return [self]
      #
      # @raise [Types::ValidationError]
      #   if the value is not true or false
      def self.validate(value)
        case value
        when TrueClass, FalseClass
          self
        else
          raise ValidationError, "#{value} must be true or false"
        end
      end

      # Convert a boolean value to a parameter acceptable to Pinboard
      #
      # @param [Boolean] value
      #   the value to convert
      #
      # @return [String]
      #   'yes' if value is true, 'no' otherwise
      def self.serialize(value)
        case value
        when TrueClass
          'yes'
        when FalseClass
          'no'
        end
      end

      # Convert a parameter from Pinboard to a boolean value
      #
      # @param [String] parameter
      #   Either 'yes' or 'no'
      #
      # @return [Boolean]
      def self.deserialize(parameter)
        case parameter
        when 'yes'
          true
        when 'no'
          false
        end
      end
    end
  end
end

# encoding: utf-8

module Thumbtack
  module Types
    # Internal: Handles conversion and validation of Boolean types to the 'yes'
    # and 'no' parameters supported by the Pinboard API.
    class Boolean
      # Validate something is a Boolean parameter.
      #
      # value - A Boolean to validate.
      #
      # Returns nothing.
      # Raises Types::ValidationError if the value is not true or false
      def self.validate(value)
        case value
        when TrueClass, FalseClass
          self
        else
          fail ValidationError, "#{value} must be true or false"
        end
      end

      # Convert a Boolean value to a parameter acceptable to the Pinboard API.
      #
      # value - A Boolean to convert.
      #
      # Returns 'yes' or 'no'
      def self.to_parameter(value)
        case value
        when TrueClass
          'yes'
        when FalseClass
          'no'
        end
      end

      # Convert a parameter from the Pinboard API to a Ruby Boolean.
      #
      # parameter - A String containing 'yes' or 'no'.
      #
      # Returns true or false.
      def self.from_parameter(parameter)
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

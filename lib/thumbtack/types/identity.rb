# encoding: utf-8

module Thumbtack
  module Types
    # Internal: An abstract type handler
    class Identity

      # Any value passed is valid.
      #
      # Returns nothing.
      def self.validate(*)
        self
      end

      # Return any value passed to this without conversion.
      def self.to_parameter(value)
        value
      end

      # Return any value passed to this without conversion.
      def self.from_parameter(parameter)
        parameter
      end
    end
  end
end

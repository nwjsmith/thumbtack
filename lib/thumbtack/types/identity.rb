# encoding: utf-8

module Thumbtack
  module Types
    # An abstract type handler with no conversion or validation
    #
    # @api private
    class Identity
      # Any value passed is valid
      #
      # @return [undefined]
      def self.validate(*)
        self
      end

      # Value is returned unconverted
      #
      # @return [value]
      def self.to_parameter(value)
        value
      end

      # Parameter is returned unconverted
      #
      # @return [parameter]
      def self.from_parameter(parameter)
        parameter
      end
    end
  end
end

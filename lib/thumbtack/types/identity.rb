# typed: true
# frozen_string_literal: true

module Thumbtack
  module Types
    # An abstract type handler with no conversion or validation
    #
    # @api private
    class Identity
      # Any value passed is valid
      #
      # @return [self]
      def self.validate(*)
        self
      end

      # Value is returned unconverted
      #
      # @param [Object] value
      #   the value to return
      #
      # @return [value]
      def self.serialize(value)
        value
      end

      # Parameter is returned unconverted
      #
      # @param [Object] parameter
      #   the parameter to return
      #
      # @return [parameter]
      def self.deserialize(parameter)
        parameter
      end
    end
  end
end

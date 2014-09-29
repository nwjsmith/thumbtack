# encoding: utf-8

module Thumbtack
  module Types
    # Handles validation of text values as supported by Pinboard
    #
    # @api private
    class Text < Identity
      # Maximum length of a text value
      MAXIMUM_LENGTH = 65_536

      # Validate text
      #
      # @param [String] value
      #   text to validate
      #
      # @return [undefined]
      #
      # @raise [Types::ValidationError]
      #   if the value is longer than 65536 characters
      def self.validate(value)
        LengthValidation.validate value, MAXIMUM_LENGTH
        self
      end
    end
  end
end

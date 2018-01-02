# frozen_string_literal: true

module Thumbtack
  module Types
    # Handles validation of title values as supported by Pinboard
    #
    # @api private
    class Title < Identity
      # Maximum length of a title value
      MAXIMUM_LENGTH = 255

      # Validate a title
      #
      # @param [String] value
      #   the title to validate
      #
      # @return [self]
      #
      # @raise [Types::ValidationError]
      #   if the value is longer than 255 characters
      def self.validate(value)
        LengthValidation.validate value, MAXIMUM_LENGTH
        self
      end
    end
  end
end

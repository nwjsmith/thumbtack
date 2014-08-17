# encoding: utf-8

module Thumbtack
  module Types
    # Internal: Handles validation of text values as supported by Pinboard.
    class Text < Identity
      # Maximum length of a text value.
      MAXIMUM_LENGTH = 65_536

      # Validate text.
      #
      # value - A String containing the text to validate.
      #
      # Returns nothing.
      # Raises Types::ValidationError if the value is longer than 65536
      # characters.
      def self.validate(value)
        unless value.length <= MAXIMUM_LENGTH
          fail ValidationError,
               "#{value} cannot be greater than #{MAXIMUM_LENGTH} characters"
        end
        self
      end
    end
  end
end

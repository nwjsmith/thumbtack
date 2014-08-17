# encoding: utf-8

module Thumbtack
  module Types
    # Internal: Handles validation of title values as supported by Pinboard.
    class Title < Identity
      # Maximum length of a title value.
      MAXIMUM_LENGTH = 255

      # Validate a title.
      #
      # value - A String containing the title to validate.
      #
      # Returns nothing.
      # Raises Types::ValidationError if the value is longer than 255
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

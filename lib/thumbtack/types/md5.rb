# encoding: utf-8

module Thumbtack
  module Types
    # Internal: Handles validation of MD5 types as the values supported by the
    # Pinboard API.
    class MD5 < Identity
      # The length of an MD5 value.
      LENGTH = 32
      # The valid characters in an MD5 value.
      CHARACTERS = '0123456789abcdf'.freeze

      # Validate something is a valid MD5 parameter.
      #
      # value - A String containing the MD5 to validate.
      #
      # Returns nothing.
      # Raises Types::ValidationError if the value is not a 32 character
      # hexadecimal MD5 hash.
      def self.validate(value)
        unless value.length == 32 &&
            value.each_char.all? { |char| CHARACTERS.include?(char) }
          fail ValidationError,
               "#{value} must be a 32 character hexadecimal MD5 hash"
        end
        self
      end
    end
  end
end

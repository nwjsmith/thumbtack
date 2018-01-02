# frozen_string_literal: true

module Thumbtack
  module Types
    # Handles validation of MD5 types as the values supported by Pinboard
    #
    # @api private
    class MD5 < Identity
      # The length of an MD5 value
      LENGTH = 32
      # The valid characters in an MD5 value
      CHARACTERS = '0123456789abcdf'

      # Validate a string is a valid MD5 parameter
      #
      # @param [String] value
      #   the MD5 to validate
      #
      # @return [self]
      #
      # @raise [Types::ValidationError]
      #   if the value is not a 32 character hexadecimal MD5 hash
      def self.validate(value)
        unless valid_md5?(value)
          raise ValidationError,
                "#{value} must be a 32 character hexadecimal MD5 hash"
        end
        self
      end

      # If true, the value is a valid MD5 string
      #
      # @param [String] value
      #   the MD5 to validate
      #
      # @return [Boolean]
      #
      # @api private
      def self.valid_md5?(value)
        value.length == LENGTH &&
          value.each_char.all? { |char| CHARACTERS.include?(char) }
      end
      private_class_method :valid_md5?
    end
  end
end

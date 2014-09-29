# encoding: utf-8

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
      # @return [undefined]
      #
      # @raise [Types::ValidationError]
      #   if the value is longer than 255 characters
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

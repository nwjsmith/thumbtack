# encoding: utf-8

module Thumbtack
  module Types
    # Internal: Handles validation of tag lists as the values supported by the
    # Pinboard API.
    class Tags
      # The maximum tag length.
      MAXIMUM_LENGTH = 255
      # Tags cannot have commas.
      INVALID_CHARACTER = ','.freeze
      # Tag parameters are separated by spaces.
      SEPARATOR = ' '.freeze

      # Validate a tags value.
      #
      # value - A String containing a single tag or an Array containing many
      #         tags.
      #
      # Returns nothing.
      # Raises Types::ValidationError if any tag contains commas or are longer
      # than 255 characters.
      def self.validate(value)
        Array(value).each do |tag|
          unless tag.length < MAXIMUM_LENGTH && !tag.include?(INVALID_CHARACTER)
            fail ValidationError,
                 "#{tag} cannot contain commas or be longer than 255 characters"
          end
        end
        self
      end

      # Convert a tag value to a parameter acceptable to the Pinboard API.
      #
      # value - A String containing a single tag or an Array containing many
      #         tags.
      #
      # Returns a String containing the tags, space-separated.
      def self.to_parameter(value)
        Array(value).map(&:strip).join(SEPARATOR)
      end

      # Convert a parameter from the Pinboard API to an Array of tags.
      #
      # parameter - A String containing space-separated tags.
      #
      # Returns an Array of tags.
      def self.from_parameter(parameter)
        parameter.split(SEPARATOR)
      end
    end
  end
end

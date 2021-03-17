# typed: true
# frozen_string_literal: true

module Thumbtack
  module Types
    # Handles conversion and validation of tag lists to values supported by
    # Pinboard
    #
    # @api private
    class Tags
      # The maximum tag length
      MAXIMUM_LENGTH = 255
      # Tags cannot have commas
      INVALID_CHARACTER = ","
      # Tag parameters are separated by spaces
      SEPARATOR = " "

      # Validate a tags value
      #
      # @param [String, Array<String>] value
      #   a single tag or an array of many tags
      #
      # @return [self]
      #
      # @raise [Types::ValidationError]
      #   if any tags contain commas or are longer than 255 characters
      def self.validate(value)
        Array(value).each do |tag|
          next if tag_valid?(tag)

          raise ValidationError,
            "#{tag} cannot contain commas or be longer than 255 characters"
        end
        self
      end

      # Convert a tag value to a parameter acceptable to Pinboard
      #
      # @param [String, Array<String>] value
      #   a single tag or an array of many tags
      #
      # @return [String]
      #   space-separated list of tags
      def self.serialize(value)
        Array(value).map(&:strip).join(SEPARATOR)
      end

      # Convert a parameter from Pinboard to a list of tags
      #
      # @param [String] parameter
      #   space-separated list of tags
      #
      # @return [Array<String>]
      def self.deserialize(parameter)
        parameter.split(SEPARATOR)
      end

      # If true, the tag is valid
      #
      # @param [String] tag
      #   a tag to validate
      #
      # @return [Boolean]
      #
      # @api private
      def self.tag_valid?(tag)
        tag.length < MAXIMUM_LENGTH && !tag.include?(INVALID_CHARACTER)
      end
      private_class_method :tag_valid?
    end
  end
end

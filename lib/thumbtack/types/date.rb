# encoding: utf-8

module Thumbtack
  module Types
    # Internal: Handles conversion and validation of Date types to the String
    # parameters supported by the Pinboard API.
    class Date
      # The earliest allowable date
      EARLIEST = ::Date.new(1, 1, 1)
      # The latest allowable date
      LATEST = ::Date.new(2100, 1, 1)

      # Validate a Date.
      #
      # value - The Date to validate.
      #
      # Returns nothing.
      # Raises Types::ValidationError if the date is not between 0001-01-01 and
      # 2100-01-01.
      def self.validate(value)
        unless value > EARLIEST && value < LATEST
          fail ValidationError,
               "#{value} must be between 0001-01-01 and 2100-01-01"
        end
        self
      end

      # Convert a Date value to a parameter acceptable to the Pinboard API.
      #
      # value - The Date to convert.
      #
      # Returns a String containing the date with format yyyy-mm-dd.
      def self.to_parameter(value)
        value.xmlschema
      end

      # Convert a parameter from the Pinboard API to a Ruby Date.
      #
      # parameter - A String of the date formatted yyyy-mm-dd.
      #
      # Returns a Date.
      def self.from_parameter(parameter)
        ::Date.xmlschema(parameter)
      end
    end
  end
end

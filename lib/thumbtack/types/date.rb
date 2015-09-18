# encoding: utf-8

module Thumbtack
  module Types
    # Handles conversion and validation of Dates to parameters supported by
    # Pinboard
    #
    # @api private
    class Date
      # The earliest allowable date
      EARLIEST = ::Date.new(1, 1, 1)
      # The latest allowable date
      LATEST = ::Date.new(2100, 1, 1)

      # Validate a date
      #
      # @param [Date] value
      #   the date to validate
      #
      # @return [self]
      #
      # @raise [Types::ValidationError]
      #   if the date is not between 0001-01-01 and 2100-01-01
      def self.validate(value)
        RangeValidation.validate value, EARLIEST..LATEST
        self
      end

      # Convert a date to a parameter acceptable to Pinboard
      #
      # @param [Date] value
      #   the date to convert
      #
      # @return [String]
      #   the date with format yyyy-mm-dd
      def self.serialize(value)
        value.xmlschema
      end

      # Convert a parameter from Pinboard to a date
      #
      # @param [String] parameter
      #   the date with format yyyy-mm-dd
      #
      # @return [Date]
      def self.deserialize(parameter)
        ::Date.xmlschema(parameter)
      end
    end
  end
end

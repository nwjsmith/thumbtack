# encoding: utf-8

module Thumbtack
  module Types
    # Handles conversion and validation of DateTime types to the String
    # parameters supported by the Pinboard API.
    class DateTime
      # The earliest allowable time
      EARLIEST = ::DateTime.new(1, 1, 1)
      # The latest allowable time
      LATEST = ::DateTime.new(2100, 1, 1)
      # The date format of the Pinboard API
      FORMAT = '%Y-%m-%dT%H:%M:%SZ'.freeze

      # Validate something is a valid DateTime parameter.
      #
      # value - The DateTime to validate.
      #
      # Returns nothing.
      # Raises Types::ValidationError if the time is not between
      # 0001-01-01 00:00:00 and 2100-01-01 00:00:00.
      def self.validate(value)
        unless value > EARLIEST && value < LATEST
          fail ValidationError,
               "#{value} must be between 0001-01-01 and 2100-01-01"
        end
        self
      end

      # Convert a DateTime value to a parameter acceptable to the Pinboard API.
      #
      # value - The DateTime to convert.
      #
      # Returns a String containing the date with format yyyy-mm-ddTHH:MM:SSZ.
      def self.to_parameter(value)
        value.strftime(FORMAT)
      end

      # Convert a parameter from the Pinboard API to a Ruby DateTime.
      #
      # parameter - A String of the date formatted yyyy-mm-ddTHH:MM:SSZ.
      #
      # Returns a DateTime.
      def self.from_parameter(parameter)
        ::DateTime.strptime(parameter)
      end
    end
  end
end

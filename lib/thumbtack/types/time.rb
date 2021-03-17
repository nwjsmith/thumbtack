# typed: true
# frozen_string_literal: true

module Thumbtack
  module Types
    # Handles conversion and validation of Times to parameters supported by
    # Pinboard
    #
    # @api private
    class Time
      # The earliest allowable time
      EARLIEST = ::Time.new(1, 1, 1, 0, 0, 0, 0)
      # The latest allowable time
      LATEST = ::Time.new(2100, 1, 1, 0, 0, 0, 0)
      # Pinboard's date time format
      FORMAT = "%Y-%m-%dT%H:%M:%SZ"
      # Pinboard's date time format for notes
      NOTE_FORMAT = "%Y-%m-%d %H:%M:%S"

      # Validate a time
      #
      # @param [Time] value
      #   The time to validate
      #
      # @return [self]
      #
      # @raise [Types::ValidationError]
      #   if the time is not between 0001-01-01 00:00:00 and 2100-01-01 00:00:00
      def self.validate(value)
        RangeValidation.validate value, EARLIEST..LATEST
        self
      end

      # Convert a time to a parameter acceptable to Pinboard
      #
      # @param [Time] value
      #   the time to convert
      #
      # @return [String]
      #   the time formatted yyyy-mm-ddTHH:MM:SSZ.
      def self.serialize(value)
        value.strftime(FORMAT)
      end

      # Convert a parameter from Pinboard to a datetime value
      #
      # @param [String] parameter
      #   the time formatted yyyy-mm-ddTHH:MM:SSZ
      #
      # @return [Time]
      def self.deserialize(parameter)
        ::Time.strptime(parameter, FORMAT)
      end

      # Convert a parameter from Pinboard's notes to a datetime value
      #
      # @param [String] parameter
      #   the time formatted yyyy-mm-dd HH:MM:SS
      #
      # @return [Time]
      def self.deserialize_from_note(parameter)
        ::Time.strptime(parameter, NOTE_FORMAT)
      end
    end
  end
end

# encoding: utf-8

module Thumbtack
  module Types
    # Handles conversion and validation of DateTimes to parameters supported by
    # Pinboard
    #
    # @api private
    class DateTime
      # The earliest allowable time
      EARLIEST = ::DateTime.new(1, 1, 1)
      # The latest allowable time
      LATEST = ::DateTime.new(2100, 1, 1)
      # Pinboard's date format
      FORMAT = '%Y-%m-%dT%H:%M:%SZ'.freeze

      # Validate a time
      #
      # @param [DateTime] value
      #   The time to validate
      #
      # @return [undefined]
      #
      # @raise [Types::ValidationError]
      #   if the time is not between 0001-01-01 00:00:00 and 2100-01-01 00:00:00
      def self.validate(value)
        unless value > EARLIEST && value < LATEST
          fail ValidationError,
               "#{value} must be between 0001-01-01 and 2100-01-01"
        end
        self
      end

      # Convert a time to a parameter acceptable to Pinboard
      #
      # @param [DateTime] value
      #   the time to convert
      #
      # @return [String]
      #   the time formatted yyyy-mm-ddTHH:MM:SSZ.
      def self.to_parameter(value)
        value.strftime(FORMAT)
      end

      # Convert a parameter from Pinboard to a datetime value
      #
      # @param [String] parameter
      #   the time formatted yyyy-mm-ddTHH:MM:SSZ
      #
      # @return [DateTime]
      def self.from_parameter(parameter)
        ::DateTime.strptime(parameter)
      end
    end
  end
end

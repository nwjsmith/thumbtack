# encoding: utf-8

module Thumbtack
  module Types
    class DateTime
      EARLIEST = ::DateTime.new(1, 1, 1)
      LATEST = ::DateTime.new(2100, 1, 1)
      FORMAT = '%Y-%m-%dT%H:%M:%SZ'.freeze

      def self.validate(value)
        unless value > EARLIEST && value < LATEST
          fail ValidationError,
               "#{value} must be between 0001-01-01 and 2100-01-01"
        end
        self
      end

      def self.to_parameter(value)
        value.strftime(FORMAT)
      end

      def self.from_parameter(parameter)
        ::DateTime.strptime(parameter)
      end
    end
  end
end

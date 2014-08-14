# encoding: utf-8

require 'date'

module Thumbtack
  module Types
    class Date
      EARLIEST = ::Date.new(1, 1, 1)
      LATEST = ::Date.new(2100, 1, 1)

      def self.validate(value)
        unless value > EARLIEST && value < LATEST
          fail ValidationError,
               "#{value} must be between 0001-01-01 and 2100-01-01"
        end
        self
      end

      def self.to_parameter(value)
        value.xmlschema
      end

      def self.from_parameter(parameter)
        ::Date.xmlschema(parameter)
      end
    end
  end
end

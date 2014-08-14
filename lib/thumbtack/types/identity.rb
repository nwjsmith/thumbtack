# encoding: utf-8

module Thumbtack
  module Types
    class Identity
      def self.validate(*)
        self
      end

      def self.to_parameter(value)
        value
      end

      def self.from_parameter(parameter)
        parameter
      end
    end
  end
end

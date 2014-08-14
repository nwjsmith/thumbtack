# encoding: utf-8

module Thumbtack
  module Types
    class Boolean
      def self.validate(value)
        case value
        when TrueClass, FalseClass
          self
        else
          fail ValidationError, "#{value} must be true or false"
        end
      end

      def self.to_parameter(value)
        case value
        when TrueClass
          'yes'
        when FalseClass
          'no'
        end
      end

      def self.from_parameter(parameter)
        case parameter
        when 'yes'
          true
        when 'no'
          false
        end
      end
    end
  end
end

# encoding: utf-8

module Thumbtack
  module Types
    class Text < Identity
      MAXIMUM_LENGTH = 65_536

      def self.validate(value)
        unless value.length <= MAXIMUM_LENGTH
          fail ValidationError,
               "#{value} cannot be greater than #{MAXIMUM_LENGTH} characters"
        end
        self
      end
    end
  end
end

# encoding: utf-8

module Thumbtack
  module Types
    class Title < Identity
      MAXIMUM_LENGTH = 255

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

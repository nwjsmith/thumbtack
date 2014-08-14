# encoding: utf-8

module Thumbtack
  module Types
    class Tags
      MAXIMUM_LENGTH = 255
      COMMA = ','.freeze
      SPACE = ' '.freeze

      def self.validate(value)
        Array(value).each do |tag|
          unless tag.length < MAXIMUM_LENGTH && !tag.include?(COMMA)
            fail ValidationError,
                 "#{tag} cannot contain commas or be longer than 255 characters"
          end
        end
        self
      end

      def self.to_parameter(value)
        Array(value).map(&:strip).join(SPACE)
      end

      def self.from_parameter(parameter)
        parameter.split(SPACE)
      end
    end
  end
end

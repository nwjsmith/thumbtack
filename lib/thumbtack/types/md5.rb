# encoding: utf-8

module Thumbtack
  module Types
    class MD5 < Identity
      LENGTH = 32
      CHARACTERS = '0123456789abcdf'.freeze

      def self.validate(value)
        unless value.length == 32 &&
            value.each_char.all? { |char| CHARACTERS.include?(char) }
          fail ValidationError,
               "#{value} must be a 32 character hexadecimal MD5 hash"
        end
        self
      end
    end
  end
end

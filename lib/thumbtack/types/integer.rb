# encoding: utf-8

module Thumbtack
  module Types
    class Integer < Identity
      MIN = 0
      MAX = 2**32

      def self.validate(value)
        unless value >= MIN && value <= MAX
          fail ValidationError, "#{value} must be in range 0..2^32"
        end
        self
      end
    end
  end
end

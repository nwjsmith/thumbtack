# encoding: utf-8

module Thumbtack
  module Types
    class URL < Identity
      VALID_SCHEMES = %w(http https javascript mailto ftp file feed).freeze

      def self.validate(value)
        unless VALID_SCHEMES.include? URI(value).scheme
          fail ValidationError,
               "scheme must be one of #{VALID_SCHEMES.join(', ')}"
        end
        self
      end
    end
  end
end

# encoding: utf-8

module Thumbtack
  module Types
    # Internal: Handles validation of URL values as supported by Pinboard.
    class URL < Identity
      # Valid URL schemes.
      VALID_SCHEMES = %w(http https javascript mailto ftp file feed).freeze

      # Validate a URL.
      #
      # value - A String containing the URL to validate.
      #
      # Returns nothing.
      # Raises Types::ValidationError if the URL's scheme isn't one of http,
      # https, javascript, mailto, ftp, file, or feed.
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

# encoding: utf-8

module Thumbtack
  module Types
    # Handles validation of URL values as supported by Pinboard
    #
    # @api private
    class URL < Identity
      # Valid URL schemes
      VALID_SCHEMES = %w(http https javascript mailto ftp file feed).freeze

      # Validate a URL
      #
      # @param [String] value
      #   the URL to validate
      #
      # @return [self]
      #
      # @raise [Types::ValidationError]
      #   if the URL's scheme isn't one of http, https, javascript, mailto, ftp,
      #   file, or feed
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

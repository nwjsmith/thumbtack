# encoding: utf-8

module Thumbtack
  # Handlers for each of the data types in the Pinboard API. See
  # https://pinboard.in/api/#data
  module Types
    # Internal: Raised when given an invalid argument
    class ValidationError < StandardError; end
  end
end

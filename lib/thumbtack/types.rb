# encoding: utf-8

module Thumbtack
  # Handlers for each of the data types in the Pinboard API
  #
  # @see https://pinboard.in/api/#data
  module Types
    # Raised when given an argument that does not satisfy the type constraints
    class ValidationError < StandardError; end
  end
end

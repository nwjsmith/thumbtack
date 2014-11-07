# encoding: utf-8

# A simple Pinboard API wrapper
module Thumbtack
  # Raised when the API rate limit has been reached
  class RateLimitError < StandardError; end

  # Raised when given an invalid parameter
  class ValidationError < StandardError; end

  # Raised when given an error from a Pinboard result code
  #
  # @see https://pinboard.in/api/#errors
  class ResultError < StandardError; end

  # An empty Hash to use for default options
  EMPTY_HASH = {}.freeze

  # An empty Hash to use for `#fetch` fallbacks
  EMPTY_ARRAY = [].freeze
end

require 'date'
require 'json'
require 'net/http'
require 'uri'

require 'thumbtack/types/range_validation'
require 'thumbtack/types/length_validation'
require 'thumbtack/types/boolean'
require 'thumbtack/types/date'
require 'thumbtack/types/date_time'
require 'thumbtack/types/identity'
require 'thumbtack/types/integer'
require 'thumbtack/types/md5'
require 'thumbtack/types/tags'
require 'thumbtack/types/text'
require 'thumbtack/types/title'
require 'thumbtack/types/url'
require 'thumbtack/specification'
require 'thumbtack/post'
require 'thumbtack/suggestion'
require 'thumbtack/posts'
require 'thumbtack/tags'
require 'thumbtack/user'
require 'thumbtack/hash_to_digest'
require 'thumbtack/symbolize_keys'
require 'thumbtack/note'
require 'thumbtack/note_summary'
require 'thumbtack/notes'
require 'thumbtack/adapters/basic_adapter'
require 'thumbtack/client'
require 'thumbtack/version'

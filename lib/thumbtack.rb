# encoding: utf-8

# A simple Pinboard API wrapper
module Thumbtack
  # An empty Hash to use for default options
  EMPTY_HASH = {}.freeze

  # An empty Hash to use for `#fetch` fallbacks
  EMPTY_ARRAY = [].freeze
end

require 'date'
require 'json'
require 'net/http'
require 'uri'

require 'thumbtack/types'
require 'thumbtack/types/range_validation'
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
require 'thumbtack/note'
require 'thumbtack/note_summary'
require 'thumbtack/notes'
require 'thumbtack/client'
require 'thumbtack/version'

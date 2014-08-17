# encoding: utf-8
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'thumbtack'
require 'minitest/autorun'

def auth_token
  File.open(File.expand_path('../auth_token.txt', __FILE__)).read.strip
end

def username
  auth_token.split(':').first
end

def token
  auth_token.split(':').last
end

include Thumbtack

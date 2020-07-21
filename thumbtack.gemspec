# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thumbtack/version'

Gem::Specification.new do |spec|
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'irb', '1.2.4'
  spec.add_development_dependency 'minitest', '5.14.1'
  spec.add_development_dependency 'rake', '13.0.1'
  spec.add_development_dependency 'simplecov', '0.18.5'
  spec.add_development_dependency 'yard', '0.9.25'
  spec.authors = ['Nate Smith']
  spec.description = 'Thumbtack is a simple client for the Pinboard API'
  spec.email = ['nwjsmith@gmail.com']
  spec.files = Dir.glob('lib/**/*.rb')
  spec.homepage = 'https://github.com/nwjsmith/thumbtack'
  spec.license = 'MIT'
  spec.name = 'thumbtack'
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.4.5'
  spec.summary = 'The best Pinboard API client'
  spec.test_files = Dir.glob('test/**/*.rb')
  spec.version = Thumbtack::VERSION
end

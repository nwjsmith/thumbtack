# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thumbtack/version'

Gem::Specification.new do |spec|
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'minitest', '~> 5.3.5'
  spec.add_development_dependency 'rake', '~> 10.3.2'
  spec.add_development_dependency 'yard', '~> 0.8.7.4'
  spec.authors = ['Nate Smith']
  spec.description = 'Thumbtack is a simple client for the Pinboard API'
  spec.email = ['nwjsmith@gmail.com']
  spec.files = Dir.glob('lib/**/*.rb')
  spec.homepage = 'https://github.com/nwjsmith/thumbtack'
  spec.license = 'MIT'
  spec.name = 'thumbtack'
  spec.require_paths = ['lib']
  spec.require_ruby_version = '>= 1.9.2'
  spec.summary = 'The best Pinboard API client'
  spec.test_files = Dir.glob('test/**/*.rb')
  spec.version = Thumbtack::VERSION
end

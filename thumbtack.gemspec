# frozen_string_literal: true

require_relative "lib/thumbtack/version"

Gem::Specification.new do |spec|
  spec.add_development_dependency "bundler", "2.3.7"
  spec.add_development_dependency "codecov", "0.6.0"
  spec.add_development_dependency "irb", "1.4.1"
  spec.add_development_dependency "minitest", "5.15.0"
  spec.add_development_dependency "minitest-autotest", "1.1.1"
  spec.add_development_dependency "rake", "13.0.6"
  spec.add_development_dependency "standardrb", "1.0.1"
  spec.add_development_dependency "simplecov", "0.21.2"
  spec.add_development_dependency "yard", "0.9.27"
  spec.authors = ["Nate Smith"]
  spec.description = "Thumbtack is a simple client for the Pinboard API"
  spec.email = ["nwjsmith@gmail.com"]
  spec.files = Dir.glob("lib/**/*.rb")
  spec.homepage = "https://github.com/nwjsmith/thumbtack"
  spec.license = "MIT"
  spec.name = "thumbtack"
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.5.8"
  spec.summary = "The best Pinboard API client"
  spec.test_files = Dir.glob("test/**/*.rb")
  spec.version = Thumbtack::VERSION
end

# -*- encoding: utf-8 -*-
# stub: standardrb 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "standardrb".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Justin Searls".freeze]
  s.bindir = "exe".freeze
  s.date = "2018-11-28"
  s.email = ["searls@gmail.com".freeze]
  s.homepage = "https://github.com/testdouble/standardrb".freeze
  s.rubygems_version = "3.2.3".freeze
  s.summary = "Alias for the standard gem, which has a standardrb binary".freeze

  s.installed_by_version = "3.2.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<standard>.freeze, [">= 0"])
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.17"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
  else
    s.add_dependency(%q<standard>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.17"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
  end
end

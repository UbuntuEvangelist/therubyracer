# -*- encoding: utf-8 -*-
# stub: osaka 0.4.13 ruby lib

Gem::Specification.new do |s|
  s.name = "osaka".freeze
  s.version = "0.4.13"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Bas Vodde".freeze]
  s.date = "2016-01-21"
  s.description = "Osaka wraps osascript (Applescript) and provides a ruby interface for automating tasks through the GUI on Mac".freeze
  s.email = "basv@odd-e.com".freeze
  s.homepage = "https://github.com/basvodde/osaka".freeze
  s.rubygems_version = "3.0.6".freeze
  s.summary = "Osaka is an Mac GUI automation library".freeze

  s.installed_by_version = "3.0.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 2.0.0"])
    else
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, [">= 2.0.0"])
    end
  else
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 2.0.0"])
  end
end

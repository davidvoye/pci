# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "zen-grids"
  s.version = "1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["John Albin Wilkins"]
  s.date = "2013-04-02"
  s.description = "Zen Grids is an intuitive, flexible grid system that leverages the natural source order of your content to make it easier to create fluid responsive designs. With an easy-to-use Sass mixin set, the Zen Grids system can be applied to an infinite number of layouts, including responsive, adaptive, fluid and fixed-width layouts."
  s.email = "virtually.johnalbin@gmail.com"
  s.homepage = "http://zengrids.com"
  s.licenses = ["GPL-2"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "1.4"
  s.rubygems_version = "1.8.23"
  s.summary = "A Compass plugin for Zen Grids, a fluid responsive grid system"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sass>, [">= 3.1"])
    else
      s.add_dependency(%q<sass>, [">= 3.1"])
    end
  else
    s.add_dependency(%q<sass>, [">= 3.1"])
  end
end

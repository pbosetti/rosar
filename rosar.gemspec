# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rosar}
  s.version = "0.1.4"
  s.license = "MIT"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Paolo Bosetti"]
  s.date = %q{2012-04-18}
  s.description = %q{Ruby/GNU-R interface that uses OSA under OS X, compatible with Ruby 1.9.x.}
  s.email = %q{paolo.bosetti@me.com}
  s.files = %w[README.markdown lib/rosar.rb test/rtest.rb]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/pbosetti/rosar}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{rosar}
  s.rubygems_version = %q{1.2.0}
  s.has_rdoc = true
  s.summary = %q{Ruby/GNU-R interface that uses OSA under OS X.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rubyosa19>, [">= 0.6.2"])
    else
      s.add_dependency(%q<rubyosa19>, [">= 0.6.2"])
    end
  else
    s.add_dependency(%q<rubyosa19>, [">= 0.6.2"])
  end
end
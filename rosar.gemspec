spec = Gem::Specification.new do |s|
  s.name = "rosar"
  s.version = "0.0.3"
  s.date = "2009-03-19"
  s.summary = "Ruby to R via OSA."
  s.email = "paolo.bosetti@me.com"
  #s.homepage = "http://www.example.com"
  s.description = %{Ruby/GNU-R interface that uses OSA under OS X.}
  s.authors = ['Paolo Bosetti']
  # the lib path is added to the LOAD_PATH
  s.require_path = "lib"
  # include Rakefile, gemspec, README and all the source files
  s.files = ["rosar.gemspec", "README"] +
    Dir.glob("lib/**/*")
  # include tests and specs
  s.test_files = Dir.glob("{test,spect}/**/*")
  # include README while generating rdoc
  s.rdoc_options = ["--main", "README"]
  s.has_rdoc = true
  s.extra_rdoc_files = ["README"]
end
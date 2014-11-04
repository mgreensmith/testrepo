# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name          = "testrepo"
  gem.version       = IO.read(File.expand_path(File.dirname(__FILE__)+"/version"))
  gem.summary       = %q{Shows build status}
  gem.description   = %q{Shows build status}
  gem.license       = "MIT"
  gem.authors       = ["Matt Grensmith"]
  gem.email         = "mgreensmith@cozy.co"
  gem.homepage      = "https://github.com/mgreensmith/testrepo"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = []

end
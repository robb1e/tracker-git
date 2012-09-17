# -*- encoding: utf-8 -*-
require File.expand_path('../lib/tracker-git/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Robbie Clutton"]
  gem.email         = ["robert.clutton@gmail.com"]
  gem.description   = %q{Tracker integration: Update Tracker based on current Git repo.}
  gem.summary       = %q{Tracker integration.}
  gem.homepage      = ""

  gem.add_runtime_dependency 'pivotal-tracker'
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "guard-rspec"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "tracker-git"
  gem.require_paths = ["lib"]
  gem.version       = Tracker::VERSION
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rebaser/version'

Gem::Specification.new do |spec|
  spec.name          = 'rebaser'
  spec.version       = Rebaser::VERSION
  spec.authors       = ['Tim Minkov']
  spec.email         = ["timothyminkov@gmail.com"]
  spec.summary       = %q{Rebases all open pull requests on a git repo}
  spec.homepage      = 'https://github.com/timminkov/rebaser'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ['rebaser']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_runtime_dependency 'github_api'
  spec.add_runtime_dependency 'inquirer'
end

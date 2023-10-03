# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cheatset/version'

Gem::Specification.new do |spec|
  spec.name          = 'cheatset'
  spec.version       = Cheatset::VERSION
  spec.authors       = ['Bogdan Popescu']
  spec.description   = 'Generate cheat sheets for Dash'
  spec.summary       = spec.description
  spec.homepage      = 'https://github.com/Kapeli/cheatset'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'

  spec.add_dependency 'thor', '>= 1.0.1', '< 2.0'
  spec.add_dependency 'haml', '> 5.2', '< 6.0'
  spec.add_dependency 'sqlite3', '>= 1.3.13', '< 1.4'
  spec.add_dependency 'plist', '>= 3.5.0', '< 4.0'
  spec.add_dependency 'redcarpet', '>= 3.5.1', '< 4.0'
  spec.add_dependency 'rouge', '>= 3.26.0', '< 4.0'
  spec.add_dependency 'sanitize', '>= 5.2.1', '< 6.0'
  spec.add_dependency 'unindent', '>= 1.0', '< 1.1'
end

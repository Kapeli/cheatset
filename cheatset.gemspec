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

  spec.add_dependency 'thor'
  spec.add_dependency 'haml'
  spec.add_dependency 'sqlite3'
  spec.add_dependency 'plist'
  spec.add_dependency 'redcarpet'
  spec.add_dependency 'rouge'
  spec.add_dependency 'sanitize'
  spec.add_dependency 'unindent'
end

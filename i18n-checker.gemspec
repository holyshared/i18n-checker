# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'i18n_checker/version'

Gem::Specification.new do |spec|
  spec.name          = "i18n_checker"
  spec.version       = I18nChecker::VERSION
  spec.authors       = ["holyshared"]
  spec.email         = ["holy.shared.design@gmail.com"]
  spec.summary       = "i18n checker for haml"
  spec.description   = "It parses the haml template and checks the validity of the language file"
  spec.homepage      = "https://github.com/holyshared/i18n-checker"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.add_dependency 'haml_parser', '~> 0.4'
  spec.add_dependency 'colorator', '~> 1.1.0'
  spec.add_dependency 'parser'
  spec.add_development_dependency 'bundler','~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'simplecov-console'
  spec.add_development_dependency 'coveralls'
end

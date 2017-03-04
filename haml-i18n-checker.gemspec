# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'haml/i18n/checker/version'

Gem::Specification.new do |spec|
  spec.name          = "haml-i18n-checker"
  spec.version       = Haml::I18n::Checker::VERSION
  spec.authors       = ["holyshared"]
  spec.email         = ["holy.shared.design@gmail.com"]
  spec.summary       = "i18n checker for haml"
  spec.description   = "It parses the haml template and checks the validity of the language file"
  spec.homepage      = "https://github.com/holyshared/haml-i18n-checker"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]
  spec.add_dependency "haml_parser", "~> 0.4"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
end

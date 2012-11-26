# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wave/version'

Gem::Specification.new do |gem|
  gem.name          = "wave"
  gem.version       = Wave::VERSION
  gem.authors       = ["ranaramez"]
  gem.email         = ["rana.ramez@mashsolvents.com"]
  gem.description   = %q{Ruby client for Raneen's API}
  gem.summary       = %q{Ruby client for Raneen's API}
  gem.homepage      = "https://github.com/mash-ltd/wave"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'omniauth-oauth2', '~> 1.1'
  gem.add_runtime_dependency 'httparty', "~> 0.9.0"
end

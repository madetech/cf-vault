lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cf/vault/version'

Gem::Specification.new do |spec|
  spec.name          = 'cf-vault'
  spec.version       = CF::Vault::VERSION
  spec.authors       = ['Emile Swarts', 'Chris Blackburn']
  spec.email         = ['emile@madetech.co.uk', 'chris@madetech.co.uk']
  spec.summary       = %q{Rake tasks for syncronising secrets between Hashicorp Vault and Cloud Foundry applications}
  spec.homepage      = 'https://github.com/madetech/cf-vault'
  spec.license       = 'MIT'

  spec.files         = Dir['{lib,spec}/**/*.rb'] + ['LICENSE', 'README.md']
  spec.test_files    = ['spec']
  spec.require_paths = ['lib']

  spec.add_dependency 'rake'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rspec', '~> 3.0.0'
  spec.add_development_dependency 'simplecov', '~> 0.7.1'
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'vault'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rb-readline'
end

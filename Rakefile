require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'cf/vault/application_environment_variables'
require 'cf/vault/jenkins_environment_variables'

RSpec::Core::RakeTask.new(:spec)

desc 'Set Jenkins Cloudfoundry environment variables from Vault'
task :cf_vault_set_jenkins_environment_variables do |key, vault_endpoint|
  CF::Vault::JenkinsEnvironmentVariables.new(key: key, vault_endpoint: vault_endpoint).set
end

desc 'Set Application environment variables from Vault'
task :cf_vault_set_application_environment_variables do |key, vault_endpoint|
  CF::Vault::ApplicationEnvironmentVariables.new(key: key, vault_endpoint: vault_endpoint).set
end

task default: :spec

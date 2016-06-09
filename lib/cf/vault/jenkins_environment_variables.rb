require 'vault'
require_relative 'vault_client'

module CF
  class Vault
    class JenkinsEnvironmentVariables
      def initialize(vault_endpoint:, key:)
        @vault_endpoint = vault_endpoint
        @key = key
      end

      def set
        set_environment_variables
      end

      private

      attr_reader :vault_endpoint, :key

      def set_environment_variables
        cloudfoundry_secrets.each { |key, value| ENV[key.to_s] = value }
      end

      def cloudfoundry_secrets
        secrets.select { |k, _| k.match(/^cf_/) }
      end

      def secrets
        return {
          cf_foo: 'bar'
        }
        client = CF::Vault::VaultClient.new(address: vault_endpoint)
        @secrets ||= client.read(key)
      end
    end
  end
end

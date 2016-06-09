require 'vault'
require_relative 'cloud_foundry_client'
require_relative 'client'

module CF
  class Vault
    class ApplicationEnvironmentVariables
      def initialize(vault_endpoint:, key:)
        @vault_endpoint = vault_endpoint
        @key = key
      end

      def set
        login_to_cloudfoundry
        set_environment_variables
      end

      private

      attr_reader :vault_endpoint, :key

      def login_to_cloudfoundry
        CF::Vault::CloudFoundryClient.login(credentials: login_credentials)
      end

      def login_credentials
        cloudfoundry_secrets.reject { |k, _| k == :cf_app }
      end

      def set_environment_variables
        CF::Vault::CloudFoundryClient.set_environment_variables(
          app_name: app_name,
          environment_variables: environment_variables
        )
      end

      def app_name
        cloudfoundry_secrets.fetch(:cf_app)
      end

      def environment_variables
        secrets.reject { |k, _| k.match(/^cf_/) }
      end

      def cloudfoundry_secrets
        secrets.select { |k, _| k.match(/^cf_/) }
      end

      def secrets
        client = CF::Vault::Client.new(address: vault_endpoint)
        @secrets ||= client.read(key)
      end
    end
  end
end

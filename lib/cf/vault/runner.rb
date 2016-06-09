require 'vault'
require_relative '../cloud_foundry'

module CF
  class Vault
    class Runner
      def initialize
        @key = 'on_staging'
        @client = ::Vault::Client.new(
          address: 'https://vault.madetech.com'
          # key: ENV.fetch('VAULT_TOKEN')
        )
      end

      def run
        login_to_cf
        set_environment_variables
      end

      private

      attr_reader :client, :key

      def login_to_cf
        CF::CloudFoundry.login(credentials: cf_login_details)
      end

      def cf_login_details
        cf_secrets.reject { |k, _| k == :cf_app }
      end

      def set_environment_variables
        CF::CloudFoundry.set_environment_variables(
          app_name: app_name,
          environment_variables: environment_variables
        )
      end

      def app_name
        cf_secrets.fetch(:cf_app)
      end


      def environment_variables
        return {
          database_url: 'http://google.com',
          database_username: 'root',
          database_password: '*S9SSST*(#'
        }
        # secrets - cf_secrets
      end

      def cf_secrets
        return {
          cf_api: 'api.run.pivotal.io',
          cf_username: 'app@example.com',
          cf_password: 'supersecret',
          cf_organisation: 'MyOrg',
          cf_space: 'MySpace',
          cf_app: 'MyApp'
        }

        # secrets.match(/cf_.*/)
      end

      def secrets
        @secrets ||= client.logical.read("secret/#{key}")
      end
    end
  end
end

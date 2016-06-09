require 'vault'
require_relative 'cloud_foundry'
require_relative 'client'

module CF
  class Vault
    class Runner
      def initialize
      end

      def run
        login_to_cf
        set_environment_variables
      end

      private

      def login_to_cf
        CF::Vault::CloudFoundry.login(credentials: cf_login_details)
      end

      def cf_login_details
        cf_secrets.reject { |k, _| k == :cf_app }
      end

      def set_environment_variables
        CF::Vault::CloudFoundry.set_environment_variables(
          app_name: app_name,
          environment_variables: environment_variables
        )
      end

      def app_name
        cf_secrets.fetch(:cf_app)
      end

      def environment_variables
        secrets.reject { |k, _| k.match(/^cf_/) }
      end

      def cf_secrets
        secrets.select { |k, _| k.match(/^cf_/) }
      end

      def secrets
        client = CF::Vault::Client.new(address: 'https://vault.madetech.com')
        @secrets ||= client.read('on_staging')
      end
    end
  end
end

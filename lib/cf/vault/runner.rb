require 'vault'

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
        login_cmd = ['cf login']

        login_cmd << cf_secrets.reject { |key, _value| key == :cf_app }.map { |key, value| "-#{key[3]} #{escape(value)}" }

        Kernel.system(login_cmd.flatten.join(' '))
      end

      def set_environment_variables
        set_environment_cmd = "cf set-env #{app_name}"

        environment_variables.each do |key, value|
          puts "#{set_environment_cmd} #{key} #{escape(value)}"
          Kernel.system("#{set_environment_cmd} #{key} #{escape(value)}")
        end
      end

      def app_name
        cf_secrets.fetch(:cf_app)
      end

      def escape(value)
        "\"#{value.gsub('"', '\"')}\""
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

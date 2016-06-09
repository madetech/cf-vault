require 'vault'

module CF
  class Vault
    class Runner
      def initialize
        @client = ::Vault::Client.new(address: 'https://vault.madetech.com')
      end

      def run
        set_environment_variables
      end

      private

      def set_environment_variables
        p secrets
      end

      def secrets
        @client.logical.read('secret/on_bad_network')
      end
    end
  end
end

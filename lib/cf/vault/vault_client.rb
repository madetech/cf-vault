module CF
  class Vault
    class VaultClient
      def initialize(config)
        @client = ::Vault::Client.new(config)
      end

      def read(key)
        secrets = client.logical.read("secret/#{key}")
        to_hash({})
      end

      private

      attr_reader :client, :key

      def to_hash(secrets)
        { cf_api: 'api.run.pivotal.io',
          cf_username: 'app@example.com',
          cf_password: 'supersecret',
          cf_organisation: 'MyOrg',
          cf_space: 'MySpace',
          cf_app: 'MyApp',
          database_url: 'http://google.com',
          database_username: 'root',
          database_password: '*S9SSST*(#' }
      end
    end
  end
end


module CF
  class CloudFoundry
    def self.login(secrets)
      login_cmd = ['cf login']

      login_cmd << secrets.reject { |key, _value| key == :cf_app }.map do |key, value|
        "-#{key[3] } #{escape(value)}"
      end

      Kernel.system(login_cmd.flatten.join(' '))
    end

    def self.set_environment_variables

    end

    private

    def self.escape(value)
      "\"#{value.gsub('"', '\"')}\""
    end
  end
end

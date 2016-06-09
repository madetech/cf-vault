module CF
  class CloudFoundry
    def self.login(credentials:)
      login_cmd = ['cf login']

      login_cmd << credentials.map { |key, value| "-#{key[3] } #{escape(value)}" }

      Kernel.system(login_cmd.flatten.join(' '))
    end

    def self.set_environment_variables(app_name:, environment_variables:)
      set_environment_cmd = "cf set-env #{app_name}"

      environment_variables.each do |key, value|
        Kernel.system("#{set_environment_cmd} #{key} #{escape(value)}")
      end
    end

    private

    def self.escape(value)
      "\"#{value.gsub('"', '\"')}\""
    end
  end
end

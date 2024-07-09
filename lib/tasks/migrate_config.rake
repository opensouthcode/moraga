# frozen_string_literal: true

namespace :data do
  namespace :migrate do
    desc 'Create a dotenv file from config/config.yml'
    task config2dotenv: :environment do
      # Create the dotenv file
      dot_env = Rails.root.join(".env.#{Rails.env}")
      if File.exist?(dot_env)
        abort("Sorry can't migrate, #{dot_env} already exists")
      else
        dot_env = File.open(dot_env, 'w')
      end

      # Load the configuration file
      config_yml = Rails.root.join('config', 'config.yml')
      begin
        CONFIG = YAML.load_file(config_yml)[Rails.env]
      rescue
        CONFIG = {}
      end

      # Write the dotenv file
      dot_env.puts '# Moraga environment variables. Check INSTALL.md for more information'
      dot_env.puts "MORAGA_NAME=\"#{CONFIG['name']}\""
      dot_env.puts "MORAGA_HOSTNAME=\"#{CONFIG['url_for_emails']}\""
      dot_env.puts "MORAGA_EMAIL_ADDRESS=\"#{CONFIG['sender_for_emails']}\""
      dot_env.puts "MORAGA_ICHAIN_ENABLED=\"#{CONFIG['authentication']['ichain']['enabled']}\"" if CONFIG.has_key?(:authentication)
      dot_env.puts "MORAGA_ERRBIT_HOST=\"#{CONFIG['errbit_host']}\""
      dot_env.puts "MORAGA_SMTP_ADDRESS=\"#{CONFIG['mail_address']}\""
      dot_env.puts "MORAGA_SMTP_PORT=\"#{CONFIG['mail_port']}\""
      dot_env.puts "MORAGA_SMTP_USERNAME=\"#{CONFIG['mail_username']}\""
      dot_env.puts "MORAGA_SMTP_PASSWORD=\"#{CONFIG['mail_password']}\""
      dot_env.puts "MORAGA_SMTP_AUTHENTICATION=\"#{CONFIG['mail_authentication']}\""
      dot_env.puts '# MORAGA_SMTP_DOMAIN="example.com"'
      dot_env.close

      puts "Migrated config/config.yml to .env.#{Rails.env}"
    end
  end
end

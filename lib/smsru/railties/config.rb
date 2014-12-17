module Smsru::Railties
  class Config < Rails::Railtie
    initializer "smsru.railties.config" do |app|
      # try to load config from separate config file ('smsmru.yml')
      config_path = Rails.root.join("config","smsru.yml")
      params = {}

      if File.file? config_path
        params = YAML.load_file(config_path)[Rails.env] || {}
      end


      # then check Rails secrets for params
      unless Rails.application.try(:secrets).nil?
        params.merge! Rails.application.secrets.smsru
      end

      Smsru.configure do |config|
        params.each do |key,val|
          config.send("#{key}=",val)
        end
      end

      # add config to Rails config
      app.config.smsru = Smsru.configuration
    end
  end
end
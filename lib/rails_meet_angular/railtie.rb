require 'slim'

module RailsMeetAngular
  class Railtie < Rails::Railtie
    config.before_configuration do
      Rails.application.config.assets.paths << "#{Rails.root}/app/assets/frontend"
      Rails.application.assets.register_engine '.slim', ::Slim::Template
    end
  end
end

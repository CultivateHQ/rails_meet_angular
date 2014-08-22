require 'slim'

module Rang
  class Railtie < Rails::Railtie
    include Rang::Util

    config.before_configuration do
      if gem_present? 'slim'
        Rails.application.assets.register_engine '.slim', ::Slim::Template
      end
    end
  end
end

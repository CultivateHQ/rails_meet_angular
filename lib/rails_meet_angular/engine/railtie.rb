module RailsMeetAngular
  class Engine < ::Rails::Engine
    initializer 'rails_meet_angular.precompile_hook', group: :all do |app|
      app.config.assets.precompile << 'templates.js.erb'
    end
  end
end

module Rang
  module Api
    module Generators
      class ConfigureGenerator < Rails::Generators::Base
        desc "Configures a sensible default API interface using active_model_serializers and angular-restmod."
        source_root File.expand_path("../templates", __FILE__)

        def add_angular_restmod_to_gemfile
          generate "rang:bower:add", "angular-restmod '~> 0.16' quiet"
        end

        def add_active_model_serializers_to_gemfile
          gem "active_model_serializers", "~> 0.9.0"
        end

        def bundle_install
          bundle!
        end

        def add_ams_initializer
          template "active_model_serializer.rb", "config/initializers/active_model_serializer.rb"
        end

        def add_route_api_scope
          route "scope 'api(/:version)', :module => :api, :version => /v\d+?/, :defaults => {format: :json} do\n    # API routes go here\n  end\n"
        end

        def add_controller_api_namespace
          empty_directory "app/controllers/api"
        end

        def add_example_serializer
          generate "serializer", "example title:string body:string"
        end

        def add_to_application_js
          application_js_path = Rails.application.assets.find_asset("application.js").pathname.to_s

          if !no? "\n\nAdd angular-restmod to application.js? [Yn]", :cyan
            inject_into_file application_js_path, after: /^\/\/= require angular$/ do
              "\n//= require angular-restmod/angular-restmod-bundle"
            end
          end
        rescue
          say "Application.js not found, not adding require for angular-restmod.", :red
        end

        def inform_of_actions
          say "\n\n      ******      \n\n"
          say "\nAPI Configured, using:\n\n", :green
          say "## Active_model_serializers", :bold
          say "An example serializer has been written in app/serializers/example_serializer.rb", :cyan
          say "You can (and should) read the full docs here: https://github.com/rails-api/active_model_serializers/tree/0-9-stable\n\n", :cyan
          say "## Angular-restmod", :bold
          say "A Rails-inspired ORM for Angular.", :cyan
          say "Full docs here: https://github.com/platanus/angular-restmod", :cyan
          say "You will need to include 'restmod' in the angular.module calls where you want to use it.\n\n", :cyan
        end

        private

        def bundle!
          Bundler.with_clean_env do
            run "bundle install"
          end
        end
      end
    end
  end
end

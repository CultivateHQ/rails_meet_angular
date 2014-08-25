module Rang
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Installs Rang."
      source_root File.expand_path("../templates", __FILE__)

      def install_initializer
        template "rang.rb", "config/initializers/rang.rb"
      end

      def install_bower
        if !no? "\n\nSet up Gemfile.bower for frontend assets? [Yn]", :cyan
          generate "rang:bower:init"
        end
      end

      def restructure_assets
        if !no? "\n\nRestructure assets/ to follow Angular recommended structure? [Yn]", :cyan
          generate "rang:assets:init"
        end
      end

      def configure_api
        if !no? "\n\nConfigure default API interface with active_model_serializers and angular-restmod? [Yn]", :cyan
          generate "rang:api:configure"
        end
      end

      def install_teaspoon
        if !no? "\n\nInstall & configure Teaspoon for Angular/Jasmine tests? [Yn]", :cyan
          generate "rang:teaspoon:install"
        end
      end

      def add_root_route
        if !no? "\n\nAdd default root route pointing to an ng-view tag? [Yn]", :cyan
          generate "rang:add_root"
        end
      end

      def usage
        say "\n\n      ******      \n\n"
        say "Rang is now set-up.\n\n", :green
        say "Use `rails g rang:bower:add package '~> 0.1'` to install bower packages.", :cyan
        say "See README for full docs: https://github.com/CultivateHQ/rang/blob/master/README.md\n\n"
      end

    end
  end
end

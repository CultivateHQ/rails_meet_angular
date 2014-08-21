module RailsMeetAngular
  module Teaspoon
    module Generators
      class InstallGenerator < Rails::Generators::Base
        desc "Installs teaspoon with sensible defaults for Angular."

        def add_teaspoon_to_gemfile
          gem_group :development, :test do
            gem "teaspoon", "~> 0.8.0"
            gem "phantomjs", "~> 1.9.0"
          end
        end

        def add_angular_mocks_to_gemfile
          generate "rails_meet_angular:bower:add", "angular-mocks '~> 1.2.0' quiet"
        end

        def bundle_install
          bundle!
        end

        def teaspoon_install
          generate "teaspoon:install"
        end

        def add_teaspoon_assets_hack
          inject_into_file "spec/teaspoon_env.rb", before: "Teaspoon.configure do |config|" do
            "# Fix for https://github.com/modeset/teaspoon/issues/197\n" +
            "Rails.application.config.assets.debug = false\n\n"
          end
        end

        def uncomment_matcher
          inject_into_file "spec/teaspoon_env.rb", after: /suite\.matcher =.*$/ do
            "\n    suite.matcher = \"{spec/javascripts,app/assets}/**/*[_.]spec.{js,js.coffee,coffee}\"\n"
          end
        end

        def require_angular_mocks
          append_file "spec/javascripts/spec_helper.js" do
            "//= require angular-mocks"
          end
        end

        def inform_of_actions
          say "\n\n      ******      \n\n"
          say "\nTeaspoon is installed, you can run `teaspoon` or visit `/teaspoon` to run tests.", :green
          say "Jasmine & angular-mocks are included.\n\n", :green
          say "You can put your specs alongside your JS like this:\n\n", :cyan
          say "    |-- posts/\n" +
              "    |   |-- posts_controller.js\n" +
              "    |   |-- posts_controller.spec.js\n\n"
          say "Or inside spec/javascripts, as you prefer.", :cyan
        end

        def inform_about_better_errors
          if Gem::Specification::find_all_by_name('better_errors').any?
            say "\nNote: the better_errors gem prevents ruby exceptions being " +
                "reported when running `teaspoon`.", :cyan
            say "See: https://github.com/modeset/teaspoon/issues/120\n\n"
          end
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

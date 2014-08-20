module RailsMeetAngular
  module Bower
    module Generators
      class AddGenerator < Rails::Generators::Base
        argument :dependency_name, type: :string
        argument :version_string, type: :string, default: ''
        desc "Adds a dependency to Gemfile.bower."

        def run_init
          generate "rails_meet_angular:bower:init" unless File.exist? 'Gemfile.bower'
        end

        def add_gem_to_bower_gemfile
          append_file "Gemfile.bower", "gem '#{gem_package}'" +
            (", '#{version_string}'" unless version_string.empty?).to_s +
            "\n"
          bundle! if run_bundler?
          puts "\033[36mDon't forget to add #{bower_package} to application.js!\033[0m" # Cyan
        end

        private

        def gem_package
          "rails-assets-#{bower_package}"
        end

        def bower_package
          dependency_name.delete('@')
        end

        def bundle!
          Bundler.with_clean_env do
            run "bundle install"
          end
        end

        def run_bundler?
          dependency_name.ends_with? '@'
        end
      end
    end
  end
end

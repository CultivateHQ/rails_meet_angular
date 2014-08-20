module RailsMeetAngular
  module Bower
    module Generators
      class InitGenerator < Rails::Generators::Base
        desc "Creates an auxilliary Gemfile for bower assets."

        def create_bower_gemfile
          create_file "Gemfile.bower", "" +
          "source 'https://rails-assets.org'\n"
        end

        def include_bower_gemfile_into_gemfile
          append_file "Gemfile", "\n"+
            "# Include Gemfile.bower for assets via https://rails-assets.org/.\n" +
            "eval(IO.read('Gemfile.bower'), binding) if File.exist? 'Gemfile.bower'\n"
        end

        def add_angular_gems
          append_file "Gemfile.bower", "" +
          "gem 'rails-assets-angular', '~> 1.2.0'\n" +
          "gem 'rails-assets-angular-route', '~> 1.2.0'\n"
          bundle!
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

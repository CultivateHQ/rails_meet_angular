module RailsMeetAngular
  module Bower
    module Generators
      class InitGenerator < Rails::Generators::Base
        desc "Creates an auxilliary Gemfile for bower assets."

        def create_bower_gemfile
          create_file "Gemfile.bower", "source 'https://rails-assets.org'\n"
        end

        def include_bower_gemfile_into_gemfile
          append_file "Gemfile", "\n"+
            "# Include bower.json for assets via https://rails-assets.org/.\n"+
            "eval(IO.read('Gemfile.bower'), binding)\n"
        end
      end

      class AddGenerator < Rails::Generators::NamedBase
        argument :dependency_name, type: :string
        desc "Adds a dependency to Gemfile.bower."

        def add_gem_to_bower_gemfile
          append_file
        end
      end
    end
  end
end

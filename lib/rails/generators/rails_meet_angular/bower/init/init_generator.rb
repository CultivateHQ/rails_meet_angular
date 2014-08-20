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
            "# Include Gemfile.bower for assets via https://rails-assets.org/.\n" +
            "eval(IO.read('Gemfile.bower'), binding) if File.exist? 'Gemfile.bower'\n"
        end
      end
    end
  end
end

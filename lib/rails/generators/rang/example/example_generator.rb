module Rang
  module Generators
    class ExampleGenerator < Rails::Generators::Base
      desc "Copies example assets to frontend."
      source_root File.expand_path("../templates", __FILE__)

      def clobber_assets
        remove_dir 'app/assets/frontend'
      end

      def copy_example
        directory 'frontend', 'app/assets/frontend/'
      end

    end
  end
end

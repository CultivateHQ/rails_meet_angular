module Rang
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Installs Rang."
      source_root File.expand_path("../templates", __FILE__)

      def install_initializer
        template 'rang.rb', 'config/initializers/rang.rb'
      end

      private

      def application_name
        Rails.application.class.parent_name
      end

    end
  end
end

module RailsMeetAngular
  module Assets
    module Generators
      class InitGenerator < Rails::Generators::Base
        desc "Sets up assets for recommended Angular structure."
        source_root File.expand_path("../templates", __FILE__)

        def deprecate_old_assets!
          empty_directory 'app/assets.removed'

          ["javascripts", "stylesheets"].each do |dir|
            if File.exist? "app/assets/#{dir}"
              say_status :move, "app/assets/#{dir} -> app/assets.removed/#{dir}"
              run "mv app/assets/#{dir} app/assets.removed/#{dir}", verbose: false
            end
            remove_dir "app/assets/#{dir}"
          end
        end

        def create_assets!
          template 'application.js', 'app/assets/frontend/application.js'
          template 'application.scss', 'app/assets/frontend/application.scss'
          template '_base.scss', 'app/assets/frontend/style/_base.scss'
          template 'components.js', 'app/assets/frontend/components/components.js'
        end

        def print_message
          say "\n\nDon't forget to add ng-app='#{application_name}' to application.html!\n\n", :cyan
        end

        private

        def application_name
          Rails.application.class.parent_name
        end

      end
    end
  end
end

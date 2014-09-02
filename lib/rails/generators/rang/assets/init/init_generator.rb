module Rang
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

        def add_html_attribute
          if !no? "\n\nAdd ng-app='#{Rang::Util.application_name}' to application.html? [Yn]", :cyan
            in_root do
              if layout_handler == "ActionView::Template::Handlers::ERB"
                gsub_file layout_file, "<html>", "<html ng-app='#{Rang::Util.application_name}'>"
              elsif layout_handler == "Slim::RailsTemplate"
                gsub_file layout_file, /^html$/, "html ng-app='#{Rang::Util.application_name}'"
              end
            end
          end
        end

        private

        def layout_file
          ::ApplicationController.new.send(:_layout).identifier
        end

        def layout_handler
          ::ApplicationController.new.send(:_layout).handler.class.to_s
        end

      end
    end
  end
end

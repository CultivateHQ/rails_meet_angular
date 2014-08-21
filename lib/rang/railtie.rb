require 'slim'

module Rang
  class Railtie < Rails::Railtie
    config.before_configuration do
      Rails.application.config.assets.paths << "#{Rails.root}/app/assets/frontend"
      Rails.application.assets.register_engine '.slim', ::Slim::Template

      # Ammend precompile selector to exclude html files
      Rails.application.config.assets.precompile = [ Proc.new { |path, fn| fn =~ /app\/assets/ && !%w(.js .css .htm).include?(File.extname(path)) }, /application.(css|js)$/ ]
      patch_sprockets_to_use_html_extension!
    end

    def patch_sprockets_to_use_html_extension!
      Rails.application.assets.send(:trail).alias_extension('.slim', '.html')

      Rails.application.assets.instance_eval do
        if {}.respond_to?(:key)
          def extension_for_mime_type(type)
            @mime_types.key(type) || mime_types.key(type)
          end
        else
          def extension_for_mime_type(type)
            @mime_types.index(type) || mime_types.index(type)
          end
        end
      end

      Rails.application.assets.register_mime_type 'text/html', '.html'
    end
  end
end

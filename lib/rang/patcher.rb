module Rang
  module Patcher
    def self.patch!
      patch_sprockets_to_use_html_extension! if Config.patch_sprockets_to_use_html_extension
      disable_html_precompilation! if Config.disable_html_precompilation
    end

    def self.patch_sprockets_to_use_html_extension!
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

    def self.disable_html_precompilation!
      # Ammend precompile selector to exclude html files
      Rails.application.config.assets.precompile = [ Proc.new { |path, fn| fn =~ /app\/assets/ && !%w(.js .css .htm .html).include?(File.extname(path)) }, /application.(css|js)$/ ]
    end

    def self.assets_folder
      Rails.application.config.assets.paths << "#{Rails.root}/app/assets/frontend"
    end
  end
end

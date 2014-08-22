module Rang
  module Config
    class << self

      attr_accessor :patch_sprockets_to_use_html_extension
      attr_accessor :disable_html_precompilation
      attr_accessor :frontend_assets_directory

    end
  end
end

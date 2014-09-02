Rang.configure do |config|

  # This does some admittedly ugly patching to allow you to address your
  # templates with the more intuitive extension '.html' rather than '.htm'.
  #
  # If you prefer, you can disable this and ensure your asset filenames follow
  # the format `file.html.slim` — you'll still need to refer to them using
  # `file.html` in your ng-routes.
  config.patch_sprockets_to_use_html_extension = true

  # This disables individual precompilation of HTML files in assets/.
  # By default Rang injects them into $templateCache instead.
  config.disable_html_precompilation = true

  # Name of folder within app/assets to use for collected assets.
  config.frontend_assets_directory = 'frontend'

end

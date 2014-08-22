Rang.configure do |config|

  # This does some admittedly ugly patching to allow you to address your
  # templates with the more intuitive extension '.html' rather than '.htm'.
  config.patch_sprockets_to_use_html_extension = true

  # This disables individual precompilation of HTML files in assets/.
  # By default Rang injects them into $templateCache instead.
  config.disable_html_precompilation = true
  
end

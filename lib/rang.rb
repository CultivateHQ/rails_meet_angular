require "rang/version"
require "rang/helpers"

if defined? Rails
  require "rang/railtie"
  require "rang/engine/railtie"
  require "ngannotate/rails"
  require "slim"
  require "angular_rails_csrf"
end

module Rang; end

require "rang/version"
require "rang/util"
require "rang/helpers"
require "rang/config"
require "rang/patcher"

if defined? Rails
  require "rang/engine/railtie"
  require "ngannotate/rails"
  require "angular_rails_csrf"
end

module Rang
  def self.configure
    yield Config
    Patcher.patch!
  end
end

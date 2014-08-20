require "rails_meet_angular/version"
require "rails_meet_angular/helpers"

if defined? Rails
  require "rails_meet_angular/railtie"
  require "rails_meet_angular/engine/railtie"
  require "ngannotate/rails"
  require "slim"
  require "angular_rails_csrf"
end

module RailsMeetAngular; end

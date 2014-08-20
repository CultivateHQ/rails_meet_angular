require "rails_meet_angular/version"
require "rails_meet_angular/helpers"
require "rails_meet_angular/railtie" if defined? Rails
require "rails_meet_angular/engine/railtie" if defined? Rails
require "ngannotate/rails" if defined? Rails
require "slim" if defined? Rails

module RailsMeetAngular; end

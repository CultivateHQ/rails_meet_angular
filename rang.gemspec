# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rang/version'

Gem::Specification.new do |spec|
  spec.name          = "rang"
  spec.version       = Rang::VERSION
  spec.authors       = ["Caden Lovelace"]
  spec.email         = ["caden@herostrat.us"]
  spec.summary       = %q{Helpful adjustments to make Rails and Angular play nice together.}
  spec.description   = %q{Provides a suite of generators and adjustments that make Rails
                          a seamless AngularJS development environment to rival Grunt and Gulp.}
  spec.homepage      = "http://github.com/cultivatehq/rang"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "slim", "~> 2.0"
  spec.add_dependency "rails", "~> 4.0"
  spec.add_dependency "ngannotate-rails", "~> 0.9"
  spec.add_dependency "angular_rails_csrf", "~> 1.0"
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_meet_angular/version'

Gem::Specification.new do |spec|
  spec.name          = "rails_meet_angular"
  spec.version       = RailsMeetAngular::VERSION
  spec.authors       = ["Caden Lovelace"]
  spec.email         = ["caden@herostrat.us"]
  spec.summary       = %q{TODO: Helpful adjustments to make Rails and Angular play nice together. }
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0.0"
  spec.add_dependency "rails", "~> 4.0"
  spec.add_dependency "slim"
end

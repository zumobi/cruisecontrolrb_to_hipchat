# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cruisecontrolrb_to_hipchat/version'

Gem::Specification.new do |spec|
  spec.name          = "cruisecontrolrb_to_hipchat"
  spec.version       = CruisecontrolrbToHipchat::VERSION
  spec.authors       = ["epinault"]
  spec.email         = ["emmanuel.pinault@zumobi.com"]
  spec.summary       = %q{A simple daemon to report last build status from cruisecontrol}
  spec.description   = %q{Inspired from https://github.com/andrewpbrett/cruisecontrolrb_to_hipchat but with support of more recent api and multiple projects}
  spec.homepage      = "http://github.com/zumobi/cruisecontrolrb_to_hipchat"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "dante", "~> 0.2.0"
  spec.add_dependency "hipchat", "~> 1.2.0"
  spec.add_dependency "nokogiri", "~> 1.6.2"  
  spec.add_dependency "httparty", "~> 0.13.1"
  spec.add_dependency "rufus-scheduler"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end

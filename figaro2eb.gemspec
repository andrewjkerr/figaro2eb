# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'figaro2eb/version'

Gem::Specification.new do |spec|
  spec.name          = "figaro2eb"
  spec.version       = Figaro2eb::VERSION
  spec.authors       = ["Andrew Kerr"]
  spec.email         = ["andrewjkerr47@gmail.com"]
  spec.summary       = %q{Generates a shell script from Figaro's application.yml to set environment variables on EB.}
  spec.description   = %q{Generates a shell script from Figaro's application.yml to set environment variables on an Elastic Beanstalk instance.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "responsive_preview/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "responsive_preview"
  s.version     = ResponsivePreview::VERSION
  s.authors     = ["Ryan Wallace", "Nicholas Jakobsen"]
  s.email       = ["hello@combinaut.com"]
  s.homepage    = "http://github.com/combinaut/responsive_preview"
  s.summary     = "Rack Middleware that injects an iframe around the response content to allow for responsive previewing"
  s.description = "Rack Middleware that injects an iframe around the response content to allow for responsive previewing"

  s.files = Dir["{app}/**/*"] + Dir["{lib}/**/*"] + ["MIT-LICENSE", "README.md"]

  s.add_dependency "rails", "> 5.2"

  s.add_development_dependency "minitest", "~> 5.0"
  s.add_development_dependency "rack-test"
  s.add_development_dependency "rake"
end

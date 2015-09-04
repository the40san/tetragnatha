$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tetragnatha/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "tetragnatha"
  spec.version     = Tetragnatha::VERSION
  spec.authors     = ["Masashi AKISUE"]
  spec.email       = ["masashi.akisue@aktsk.jp"]
  spec.homepage    = "https://github.com/aktsk/tetragnatha"
  spec.summary     = "Table migration plugin for MySQL Spider storage engine"
  spec.description = "Table migration plugin for MySQL Spider storage engine"
  spec.license     = "MIT"

  spec.files = Dir["lib/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  spec.test_files = Dir["spec/**/*"]
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", "~> 4.2.0"
  spec.add_dependency "mysql2"

  spec.add_development_dependency "rspec"
end

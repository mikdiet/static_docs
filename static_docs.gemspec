$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "static_docs/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "static_docs"
  s.version     = StaticDocs::VERSION
  s.authors     = ["Mikhail Dieterle"]
  s.email       = ["MikDiet@gmail.com"]
  s.homepage    = "https://github.com/Mik-die/static_docs"
  s.summary     = "Static documentation mounting into your Rails app"
  s.description = "Static pages can be created, stored and edited as files. Then they can be imported into DB of your app and be shown within app's layout. Rules of displaying are described in special manifest file, gem's initializer of app and in route file"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.1"

  s.add_development_dependency "sqlite3"
end

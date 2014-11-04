# encoding: utf-8

Gem::Specification.new do |gem|
  gem.name         = "fluent-plugin-curl-simple"
  gem.version      = "0.0.1"

  gem.authors      = ["Trevor Gattis"]
  gem.email        = "github@trevorgattis.com"
  gem.description  = "Simple plugin to send record data in JSON format to a given URL."
  gem.homepage     = "https://github.com/gtrevg/fluent-plugin-curl-simple"
  gem.summary      = gem.description
  gem.license      = "APLv2"
  gem.has_rdoc = false

  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_dependency "fluentd", "~> 0.10.17"
  gem.add_runtime_dependency("yajl-ruby", ["~> 1.0"])
  gem.add_runtime_dependency("curb", ["~> 0.8.6"])

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "pry"
  gem.add_development_dependency "pry-nav"
end

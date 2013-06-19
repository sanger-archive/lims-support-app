# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "lims-support-app/version"

Gem::Specification.new do |s|
  s.name        = "lims-support-app"
  s.version     = Lims::SupportApp::VERSION
  s.authors     = ["Karoly Erdos"]
  s.email       = ["ke4@sanger.ac.uk"]
  s.homepage    = "http://sanger.ac.uk/"
  s.summary     = %q{Application supporting the LIMS functionality}
  s.description = %q{Provides utility functions for the new LIMS}

  s.rubyforge_project = "lims-support-app"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # TODO: s.add_dependency('sinatra', '~> 1.3.2') # But need latest from github so in Gemfile!
  # TODO: s.add_dependency('lims-core')  it is in Gemfile because on github
  # TODO: s.add_dependency('lims-api')  it is in Gemfile because on github
  s.add_dependency('json')
  s.add_dependency('mysql2')
  s.add_dependency('sequel')

  s.add_development_dependency('rake', '~> 0.9.2')
  s.add_development_dependency('rspec', '~> 2.8.0')
  s.add_development_dependency('hashdiff')
  s.add_development_dependency('rack-test', '~> 0.6.1')
  s.add_development_dependency('yard', '>= 0.7.0')
  s.add_development_dependency('yard-rspec', '0.1')
  s.add_development_dependency('github-markup', '~> 0.7.1')

  s.add_dependency('bunny', '0.9.0.pre10')
end

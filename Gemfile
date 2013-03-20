source "http://rubygems.org"

# Specify your gem's dependencies in lims-support-app.gemspec
gemspec

gem 'sinatra', :git => 'http://github.com/sinatra/sinatra.git'
# gem 'lims-core', '~>1.4.0.0.1', :git => 'http://github.com/sanger/lims-core.git' , :branch => 'development'
gem 'lims-core', '~>1.4.0.0.1', :path => '../lims-core'
# gem 'lims-api', '~>1.2.0.2.0', :git => 'http://github.com/sanger/lims-api.git' , :branch => 'development'
gem 'lims-api', '~>1.2.0.2.0', :path => '../lims-api'

group :debugger do
  gem 'debugger'
  gem 'debugger-completion'
  gem 'shotgun'
end

group :deployment do
  gem "psd_logger", :git => "http://github.com/sanger/psd_logger.git"
  gem 'trinidad', :platforms => :jruby
  gem "trinidad_daemon_extension", :platforms => :jruby
  gem 'activesupport', '~> 3.0.0', :platforms => :jruby
  gem "mysql2"
end
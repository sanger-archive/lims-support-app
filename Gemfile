source "http://rubygems.org"

# Specify your gem's dependencies in lims-support-app.gemspec
gemspec

gem "mustache", "~> 0.99.4", :git => 'https://github.com/defunkt/mustache'
gem 'sinatra', :git => 'http://github.com/sinatra/sinatra.git', :branch => '459369eb66224836f72e21bbece58c007f3422fa'
gem 'lims-core', '~>2.1', :git => 'http://github.com/sanger/lims-core.git', :branch => 'development'
# gem 'lims-core', '~>2.0.0', :path => '../lims-core'
gem 'lims-api', '~>2.1', :git => 'http://github.com/sanger/lims-api.git', :branch => 'development'
# gem 'lims-api', '~>2.0.0', :path => '../lims-api'
gem 'lims-laboratory-app', '~>1.0', :git => 'http://github.com/sanger/lims-laboratory-app.git', :branch => 'development'

group :development do
  gem 'redcarpet', '~> 2.1.0', :platforms => :mri
  gem 'sqlite3', :platforms => :mri
end

group :debugger do
  gem 'debugger', :platforms => :mri
  gem 'debugger-completion', :platforms => :mri
  gem 'shotgun', :platforms => :mri
end

group :pry do
  gem 'debugger-pry', :require => 'debugger/pry', :platforms => :mri
  gem 'pry', :platforms => :mri
end

group :deployment do
  gem "psd_logger", :git => "http://github.com/sanger/psd_logger.git"
  gem 'trinidad', :platforms => :jruby
  gem "trinidad_daemon_extension", :platforms => :jruby
  gem 'activesupport', '~> 3.0.0', :platforms => :jruby
  gem 'jdbc-mysql', :platforms => :jruby
end

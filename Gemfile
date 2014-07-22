source 'https://rubygems.org'

gem 'rails', '3.2.12'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
#  gem 'asset_sync'
end

gem 'jquery-rails'

gem "mysql2"
gem "haml"
gem "haml-rails"
gem "bootstrap-sass", "~> 2.0.2"
gem "devise"
gem "cancan"
gem "activeadmin"
gem "meta_search", ">= 1.1.0.pre"
gem "foreman", :require => false
gem "puma", :require => false
gem "jquery-ui-rails"
gem "audited-activerecord"
gem "simple_form"
gem "valid_email"
gem "resque"
gem "resque-scheduler", require: "resque_scheduler"
gem "uuid"
gem "twilio-ruby"
gem "exceptional"
gem "rvm-capistrano"
gem "aws-ses", require: 'aws/ses'
gem "to_lang"
gem 'google-analytics-rails'
gem 'newrelic_rpm'
gem 'cache_digests'
gem 'will_paginate'


group :development do
  gem "letter_opener"
  gem "active_record_query_trace"
end

group :development, :test do
  gem "rails3-generators"
  gem "guard", :require => false
  gem "guard-rspec", :require => false
  gem "guard-spork", :require => false
  gem "growl", :require => false
  gem "pry"
  gem "pry-nav"
  gem "rack-bridge"
  gem "rspec-rails"
end

group :test do
  gem "sqlite3"
  gem "database_cleaner"
  gem "factory_girl_rails"
end

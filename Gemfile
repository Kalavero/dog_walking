# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.5.8'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'kaminari', '~> 1.1.1'
gem 'pg'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.1'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 4.11.1'
  gem 'rspec-rails', '~> 3.8'
  gem 'rubocop', ' ~> 0.60.0'
  gem 'shoulda-matchers', '4.0.0.rc1'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

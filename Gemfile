# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.5'

gem 'active_storage_validations', '0.8.9'
gem 'bcrypt',                     '3.1.13'
gem 'bootsnap',                   '>= 1.4.4', require: false
gem 'bootstrap-sass',             '3.4.1'
gem 'bootstrap-will_paginate',    '1.0.0'
gem 'faker',                      '2.1.2'
gem 'image_processing',           '1.9.3'
gem 'jbuilder',                   '~> 2.7'
gem 'mini_magick',                '4.9.5'
gem 'puma',                       '~> 5.0'
gem 'rails',                      '~> 6.1.4', '>= 6.1.4.6'
gem 'sass-rails',                 '>= 6'
gem 'turbolinks',                 '~> 5'
gem 'webpacker',                  '~> 5.0'
gem 'will_paginate',              '3.3.0'

gem 'rollbar'

group :development, :test do
  gem 'sqlite3', '~> 1.4'

  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  gem 'listen',             '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
  gem 'pry-rails'
  gem 'awesome_print'
end

group :test do
  gem 'capybara',                 '3.35.3'
  gem 'guard',                    '2.16.2'
  gem 'guard-minitest',           '2.4.6'
  gem 'minitest',                 '5.11.3'
  gem 'minitest-reporters',       '1.3.8'
  gem 'rails-controller-testing', '1.0.5'
  gem 'selenium-webdriver',       '3.142.7'
  gem 'webdrivers',               '4.6.0'

  gem 'simplecov', require: false, group: :test
end

group :production do
  gem 'pg', '1.1.4'
end

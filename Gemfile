# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'active_link_to'
gem 'activerecord-import'
gem 'activerecord-msgpack_serializer'
gem 'active_scheduler'
gem 'active_storage_validations'
gem 'ansi'
gem 'audited', '~> 5.0'
gem 'awesome_print'
gem 'bcrypt'
gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'capistrano', '~> 3.11'
gem 'capistrano-rails', '~> 1.4'
gem 'capistrano-passenger', '~> 0.2.0'
gem 'capistrano-rbenv', '~> 2.1', '>= 2.1.4'
gem 'email_validator'
gem 'ed25519', '>= 1.2', '< 2.0'
gem 'faraday'
gem 'fixed_width_file_parser'
gem 'figaro'
gem 'hiredis'
gem 'image_processing'
gem 'importmap-rails'
gem 'inline_svg'
gem 'local_time'
gem 'lograge'
gem 'mysql2'
gem 'niceql'
gem 'oj'
gem 'pagy'
gem 'premailer-rails'
gem 'pry-rails'
gem 'puma', '~> 4.3.12'
gem 'rails'
gem 'ratelimit'
gem 'redis', '~> 4.0'
gem 'redlock'
gem 'remote_syslog_logger'
gem 'resque'
gem 'resque-scheduler'
gem 'rest-client'
gem 'ring'
gem 'rubyzip', '>= 1.0.0'
gem 'sentry-rails'
gem 'sentry-ruby'
gem 'sequel', require: false
gem 'skylight'
gem 'sprockets-rails'
gem 'statsd-ruby'
gem 'stimulus-rails'
gem 'stripe'
gem 'tailwindcss-rails'
gem 'tty-prompt', require: false
gem 'turbo-rails'
gem 'view_component'

group :development, :test do
  gem 'byebug', platforms: %i(mri mingw x64_mingw)
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-its'
  gem 'rspec-match_ignoring_whitespace'
  gem 'rspec-rails'
end

group :development do
  gem 'foreman'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'simplecov'
  gem 'simplecov-cobertura', require: false
  gem 'webdrivers'
  gem 'webmock'
end

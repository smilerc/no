source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.0'

# Core Rails
gem 'rails', '~> 7.0.0'
gem 'pg', '~> 1.4'
gem 'puma', '~> 6.0'
gem 'redis', '~> 5.0'

# Authentication & Authorization
gem 'devise'
gem 'jwt'
gem 'rotp' # Two-factor authentication
gem 'rqrcode' # QR code generation
gem 'cancancan' # Authorization

# API & JSON
gem 'jbuilder'
gem 'active_model_serializers'
gem 'rack-cors'
gem 'rack-attack' # Rate limiting

# Background jobs
gem 'sidekiq'
gem 'sidekiq-web'
gem 'sidekiq-cron'

# File uploads
gem 'image_processing', '~> 1.2'
gem 'aws-sdk-s3', require: false

# Cryptocurrency gems
gem 'bitcoin-ruby'
gem 'ethereum.rb'
gem 'bitcoin-client'
gem 'web3-eth'

# HTTP clients
gem 'httparty'
gem 'faraday'
gem 'faraday-retry'

# Security
gem 'bcrypt', '~> 3.1.7'
gem 'rack-ssl-enforcer'
gem 'secure_headers'

# Monitoring & Logging
gem 'prometheus-client'
gem 'lograge'
gem 'sentry-ruby'
gem 'sentry-rails'

# Configuration
gem 'dotenv-rails'
gem 'config'

# Database
gem 'activerecord-import' # Bulk imports
gem 'pg_search' # Full text search
gem 'connection_pool'

# Admin interface
gem 'activeadmin'
gem 'arctic_admin' # Beautiful ActiveAdmin theme

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'shoulda-matchers'
  gem 'vcr' # HTTP interaction recording
  gem 'webmock'
  gem 'database_cleaner-active_record'
end

group :development do
  gem 'web-console'
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'annotate' # Model annotations
  gem 'brakeman' # Security scanner
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Performance monitoring
gem 'bootsnap', '>= 1.4.4', require: false

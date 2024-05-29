source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in ai-engine.gemspec.
gemspec

source "https://rubygems.org"

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem "tailwindcss-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Make valid URLs for capturing screenshots from user input
gem "addressable", "~> 2.8.6"

# Capture screenshots of landing pages.
gem "selenium-webdriver", "~> 4.17"

# Use the OpenAI API.
gem "ruby-openai", "~> 7.0.1"

# AWS SDK for Ruby
gem "aws-sdk-s3", "~> 1"

# A Ruby client library for Redis.
# https://github.com/redis/redis-rb
gem "redis", "~> 5.2.0"

# Simple, efficient background processing using Redis.
# https://github.com/sidekiq/sidekiq
gem "sidekiq", "~> 7.2.4"

# For Turbo Streams on Postgres
gem "actioncable-enhanced-postgresql-adapter", "~> 1.0"

# A Ruby gem to load environment variables from `.env`.
# https://github.com/bkeepers/dotenv
gem "dotenv-rails", "~> 3.1.0"

# Flexible authentication solution for Rails with Warden.
# https://github.com/heartcombo/devise
gem "devise", "~> 4.9.4"

# OmniAuth is a flexible authentication system utilizing Rack middleware.
# https://github.com/omniauth/omniauth
gem "omniauth", "~> 2.1.2"

# Oauth2 strategy for Google.
# https://github.com/zquestz/omniauth-google-oauth2
gem "omniauth-google-oauth2", "~> 1.1.2"

# Provides CSRF protection on OmniAuth request endpoint on Rails applications.
# https://github.com/cookpad/omniauth-rails_csrf_protection
gem "omniauth-rails_csrf_protection", "~> 1.0.1"

# SEO with meta tags.
# https://github.com/kpumuk/meta-tags
gem "meta-tags", "~> 2.21.0"

# An acts_as_sortable/acts_as_list replacement
# https://github.com/brendon/ranked-model
gem "ranked-model", "~> 0.4.9"

# The safe Markdown parser.
# https://github.com/vmg/redcarpet
gem "redcarpet", "~> 3.6"

group :development, :test do
  # Debugging.
  # https://github.com/ruby/debug
  gem "debug", platforms: %i[mri mingw x64_mingw]

  # Load environment variables from .env.
  gem "dotenv", "~> 3.1.0"

  # https://github.com/rspec/rspec-rails
  gem "rspec-rails", "~> 6.1.2"

  # Use FactoryBot to create test models.
  # https://github.com/thoughtbot/factory_bot_rails
  gem "factory_bot_rails", "~> 6.4.3"

  # Use Faker to generate test data.
  # https://github.com/faker-ruby/faker
  gem "faker", "~> 3.3"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Bikeshed-proof linter and formatter 🚲
  gem "standard", "~> 1.35.1"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use VCR to record HTTP interactions and replay them.
  # https://github.com/vcr/vcr
  gem "vcr", "~> 6.2.0"

  # Use WebMock to stub HTTP requests.
  # https://github.com/bblimke/webmock
  gem "webmock", "~> 3.23.0"
end

# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in stoplight-sentry.gemspec
gemspec

gem "rake", "~> 13.0"

gem "rspec", "~> 3.0"

gem "timecop"
gem "standard"

sentry_version = ENV.fetch("SENTRY_VERSION", "latest")
if sentry_version == "latest"
  gem "sentry-ruby"
else
  gem "sentry-ruby", sentry_version
end


stoplight_version = ENV.fetch("STOPLIGHT_VERSION", "latest")
if sentry_version == "latest"
  gem "stoplight"
else
  gem "stoplight", stoplight_version
end

# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in stoplight-sentry.gemspec
gemspec

gem "rake", "~> 13.0"
gem "rspec", "~> 3.0"
gem "standard"
gem "stoplight"

sentry_version = ENV.fetch("SENTRY_VERSION", "")
if sentry_version == ""
  gem "sentry-ruby"
else
  gem "sentry-ruby", sentry_version
end

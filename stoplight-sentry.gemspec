# frozen_string_literal: true

require_relative "lib/stoplight/sentry/version"

Gem::Specification.new do |spec|
  spec.name = "stoplight-sentry"
  spec.version = Stoplight::Sentry::VERSION
  spec.authors = ["Tëma Bolshakov"]
  spec.email = ["either.free@gmail.com"]

  spec.summary = "Sentry notifier for Stoplight"
  spec.description = spec.summary
  spec.homepage = "https://github.com/bolshakov/stoplight-sentry"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage + "/releases"

  spec.files = ["LICENSE.txt", "README.md"] +
    Dir.glob(File.join("lib", "**", "*.rb"))
  spec.require_paths = ["lib"]

  spec.add_dependency "stoplight", ">= 4.0"
  spec.add_dependency "sentry-ruby", ">= 5", "< 6.0"
end

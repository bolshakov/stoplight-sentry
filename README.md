# Stoplight::Sentry

Sentry notifier for Stoplight.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'stoplight-sentry'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install stoplight-sentry

## Usage

Make sure you have the [sentry-ruby] gem installed before configuring Stoplight.

```ruby
require 'sentry-ruby'

notifier = Stoplight::Sentry::Notifier.new(Sentry)
# => #<Stoplight::Sentry::Notifier:...>
Stoplight::Light.default_notifiers += [notifier]
# => [#<Stoplight::Notifier::IO:...>, #<Stoplight::Sentry::Notifier:...>]
```

you can configure notifier to add custom option to the notification:

```ruby
notifier = Stoplight::Sentry::Notifier.new(Sentry, tags: {foo: 'bar'})
# => #<Stoplight::Sentry::Notifier:...>
Stoplight::Light.default_notifiers += [notifier]
# => [#<Stoplight::Notifier::IO:...>, #<Stoplight::Sentry::Notifier:...>]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/stoplight-sentry. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/stoplight-sentry/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Stoplight::Sentry project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/stoplight-sentry/blob/main/CODE_OF_CONDUCT.md).

# Genderize::Io

[![Gem Version](https://badge.fury.io/rb/genderize-io.svg)](http://badge.fury.io/rb/genderize-io)
[![Build Status](https://travis-ci.org/drexed/genderize-io.svg?branch=master)](https://travis-ci.org/drexed/genderize-io)

API wrapper for the [Genderize.io](https://genderize.io) first name gender determination system.
*Be aware that the free API has a limit of 1000 determinations per day.*

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'genderize-io'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install genderize-io

## Usage

### Simple Lookup

```ruby
# Basic Lookup
lookup = Genderize::Io::Lookup.new('kim').determine
lookup = Genderize::Io::Lookup.determine('kim')

# Custom Options
lookup = Genderize::Io::Lookup.determine(
  'kim',
  host: 'https://api.genderize.io?api_key=xxx',
  country_id: 'dk',
  language_id: 'en'
)
```

### Simple Response

```ruby
lookup.url                    => 'https://api.genderize.io?name=kim'
lookup.data                   => { 'name' => 'kim', 'gender' => 'female', ... }

# Data Methods
lookup.name                   => 'kim'
lookup.gender                 => 'female'
lookup.probability            => 0.94
lookup.count                  => 1098
lookup.country_id             => 'dk'
lookup.language_id            => 'en'
lookup.x_rate_limit_limit     => 1000
lookup.x_rate_limit_remaining => 738
lookup.x_rate_reset           => 13829
lookup.error                  => 'sorry, my bad!'
```

### Batch Lookup

```ruby
# Basic Lookup
lookup = Genderize::Io::Batch::Lookup.new(['kim', 'jim']).determine
lookup = Genderize::Io::Batch::Lookup.determine(['kim', 'jim'])

# Custom Options
lookup = Genderize::Io::Batch::Lookup.determine(
  ['kim', 'jim'],
  host: 'https://api.genderize.io?api_key=xxx',
  country_id: 'dk',
  language_id: 'en'
)
```

### Batch Response

```ruby
lookup.url  => 'https://api.genderize.io?name[0]=kim&name[1]=jim'
lookup.data => {
  'rate_limits' => { 'x_rate_limit_limit' => 1069, ... },
  'responses' => [
    { 'name' => 'kim', 'gender' => 'female', ... },
    { 'name' => 'jim', 'gender' => 'male', ... }
  ]
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/genderize-io. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Genderize::Io project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/genderize-io/blob/master/CODE_OF_CONDUCT.md).

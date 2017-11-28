# Genderize::Io

[![Gem Version](https://badge.fury.io/rb/genderize-io.svg)](http://badge.fury.io/rb/genderize-io)
[![Build Status](https://travis-ci.org/drexed/genderize-io.svg?branch=master)](https://travis-ci.org/drexed/genderize-io)

API wrapper for the free [Genderize.io](https://genderize.io) gender determination system.

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
```ruby
# Basic Lookup
lookup = Genderize::Io::Lookup.new('kim').verify
lookup = Genderize::Io::Lookup.verify('kim')

# Custom Host
lookup = Genderize::Io::Lookup.new('kim', host: 'https://api.genderize.io?api_key=xxx').verify
lookup = Genderize::Io::Lookup.verify('kim', host: 'https://api.genderize.io?api_key=xxx')

# Custom IDs
lookup = Genderize::Io::Lookup.new('kim', country_id: 'dk').verify
lookup = Genderize::Io::Lookup.verify('kim', language_id: 'en')

# Public Methods
lookup.url                    => 'https://api.genderize.io?name=kim'
lookup.to_h                   => { 'name' => 'kim', 'gender' => 'female', ... }
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

## Contributing

Your contribution is welcome.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

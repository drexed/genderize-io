# Genderize::Io

[![Gem Version](https://badge.fury.io/rb/genderize-io.svg)](http://badge.fury.io/rb/genderize-io)
[![Build Status](https://travis-ci.org/drexed/genderize-io.svg?branch=master)](https://travis-ci.org/drexed/genderize-io)

API wrapper for the [Genderize.io](https://genderize.io) first name gender determination system.
*Be aware that the free API has a daily limit of 1000*

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

### Lookup Determination

```ruby
# Basic Lookup
lookup = Genderize::Io::Lookup.new('kim').determine
lookup = Genderize::Io::Lookup.determine('kim')

# Custom Options
lookup = Genderize::Io::Lookup.determine('kim', host: 'https://api.genderize.io?api_key=xxx',
                                                country_id: 'dk',
                                                language_id: 'en')
```

### Lookup Methods

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

### Batch Lookup Determination

```ruby
# Basic Lookup
lookup = Genderize::Io::Batch::Lookup.new(['kim', 'jim']).determine
lookup = Genderize::Io::Batch::Lookup.determine(['kim', 'jim'])

# Custom Options
lookup = Genderize::Io::Batch::Lookup.determine(['kim', 'jim'], host: 'https://api.genderize.io?api_key=xxx',
                                                                country_id: 'dk',
                                                                language_id: 'en')
```

### Batch Lookup Methods

```ruby
lookup.url  => 'https://api.genderize.io?name[0]=kim&name[1]=jim'
lookup.data => {
                 'responses' => [
                   { 'name' => 'kim', 'gender' => 'female', ... },
                   { 'name' => 'jim', 'gender' => 'male', ... }
                 ],
                 'rate_limits' => { 'x_rate_limit_limit' => 1069, ... }
               }
```

## Contributing

Your contribution is welcome.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

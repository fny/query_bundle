# QueryBundle :construction:

[![Build Status](https://travis-ci.org/fny/query_bundle.svg?branch=master)](https://travis-ci.org/fny/query_bundle)
[![Test Coverage](https://codeclimate.com/github/fny/query_bundle/badges/coverage.svg)](https://codeclimate.com/github/fny/query_bundle)
[![Code Climate](https://codeclimate.com/github/fny/query_bundle/badges/gpa.svg)](https://codeclimate.com/github/fny/query_bundle)

***Warning: Usable code spike. Feedback on the API is much appreciated.***

Batch Active Record queries and save trips to your DB. Postgres only for now.

## Usage

```ruby
bundle = QueryBundle.fetch(
  # label: ActiveRecord_Relation
  old_apples: Apple.where(age: 1000),
  green_bananas: Banana.where(age: 10)
)
bundle.day_old_apples # => [Apple<0x0>, Apple<0x1>, Apple<0x2>]
bundle.green_bananas # => [Banana<0x3>, Banana<0x4>]
```

## TODOs 

 - [Figure out how to load up an AR object so that it looks `#persisted?`](http://stackoverflow.com/questions/30826015/convert-pgresult-to-an-active-record-model)
 - MySQL support
 - Aggregate queries for records of the same model type
 - SQL/Arel support
 - Query logging
 - Concurrency testing
 - Determine namespace within ActiveRecord
 - Extract records from bundle by class
 - Create, update, delete

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'query_bundle', github: 'fny/query_bundle'
```

And then execute:

    $ bundle

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fny/query_bundle. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


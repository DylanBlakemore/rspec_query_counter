# RSpecQueryCounter

RSpecQueryCounter is a Ruby gem designed to help you optimize your test suite by giving you detailed insight into the database queries that are being executed. It tracks the total number of database queries as well as the number of queries by type (SELECT, INSERT, UPDATE, DELETE, etc.), providing you with the knowledge you need to make informed decisions about potential optimizations.

## Installation

Add this line to your application's Gemfile:

```ruby
group :test do
  gem 'rspec_query_counter'
end
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rspec_query_counter

## Usage

In `spec_helper.rb`, add the following to the RSpec configuration:

```ruby
require "rspec_query_counter" # Require the file

RSpec.configure do |config|
  ...

  RSpecQueryCounter.setup(config) # Setup the counter

  ...
end
```

Now, when you run `rspec`, you should see something like the following:

```
Total number of database queries: 512
Queries by type:
TRANSACTION: 278
Create: 81
Load: 107
Destroy: 4
Update: 19
Count: 16
Exists?: 7
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/DylanBlakemore/rspec_query_counter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/DylanBlakemore/rspec_query_counter/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RSpecQueryCounter project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/DylanBlakemore/rspec_query_counter/blob/master/CODE_OF_CONDUCT.md).

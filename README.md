# AI::Engine

Short description and motivation.

## Usage

How to use my plugin.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "ai-engine"
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install ai-engine
```

## Tests

Run the tests with `rspec`.

### VCR

AI::Engine uses VCR to record HTTP requests and responses. By default, specs are run against recorded 'cassette' fixtures.

Set OPENAI_ACCESS_TOKEN= in your .env file to run the specs against a live API and re-record all cassettes - this will cost you money!

## Contributing

Contribution directions go here.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

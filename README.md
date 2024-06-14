# AI::Engine

Short description and motivation.

## Usage

How to use AI::Engine.

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

Add the migrations and run them:

```bash
bin/rails ai_engine:install:migrations
bin/rails db:migration
```

## Test local version

```bash
gem "ai-engine", path: "../ai-engine"
```

## ENV

The dummy app needs a .env file in the root of the engine for manual and RSpec testing - see .env.example.

## Dummy app

Run the dummy app from the root of the project with `bin/dev`.

## Tests

Run the tests from the root of the project with `rspec`.

### VCR

AI::Engine uses VCR to record HTTP requests and responses. By default, specs are run against recorded 'cassette' fixtures.

Set OPENAI_ACCESS_TOKEN= in your .env file to run the specs against a live API and re-record all cassettes - this will cost you money!

## Contributing

Contribution directions go here.

## License

The gem is available under the terms of the COMMERCIAL-LICENCE.txt in this repo.

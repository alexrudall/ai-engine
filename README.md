# AI::Engine

An experimental, easy-ish way to add AI assistants to your Rails app!

## Usage

Full usage documentation can be found in the [AI Engine Starter Kit README](https://github.com/alexrudall/ai-engine-starter-kit).

## Changelog

The Changelog is also kept in the [AI Engine Starter Kit CHANGELOG](https://github.com/alexrudall/ai-engine-starter-kit/blob/main/CHANGELOG.md)

## Test local version in a Rails app

```bash
gem "ai-engine", path: "../ai-engine"
```

## ENV

The dummy app needs a .env file in the root of the engine for manual and RSpec testing - see .env.example.

## Dummy app

Run the dummy app from the root of the project with `bin/dev` in one tab and `bin/rails s` in another (so debugger will work).

## Tests

Run the tests from the root of the project with `rspec`.

### VCR

AI::Engine uses VCR to record HTTP requests and responses. By default, specs are run against recorded 'cassette' fixtures.

Set OPENAI_ACCESS_TOKEN= in your .env file to run the specs against a live API and re-record all cassettes - this will cost you money!

## Release

To release, need these set in the environment:
export KEYGEN_ACCOUNT_ID="<YOUR_KEYGEN_ACCOUNT_UUID>"
export KEYGEN_PRODUCT_ID="<YOUR_KEYGEN_PRODUCT_UUID>"
export KEYGEN_PRODUCT_TOKEN="<YOUR_KEYGEN_PRODUCT_API_TOKEN>"

- Update version.rb
- `bundle`
- Commit & push
- `rake app:ai_engine:release\[0.2.0\]`

## License

The gem is available under the terms of the COMMERCIAL-LICENCE.txt in this repo.

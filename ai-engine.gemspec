require_relative "lib/ai/engine/version"

Gem::Specification.new do |spec|
  spec.name        = "ai-engine"
  spec.version     = AI::Engine::VERSION
  spec.authors     = ["Alex Rudall"]
  spec.email       = ["hello@alexrudall.com"]
  spec.homepage    = "https://rubyaiengine.com"
  spec.summary     = "AI Engine is the fastest way to get AI into your Rails app."
  spec.description = "A Rails Engine from the creator of the ruby-openai, anthropic and midjourney gems."
  spec.license     = "COMMERCIAL-LICENCE.txt"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/alexrudall/rails-ai-starter-kit"
  spec.metadata["changelog_uri"] = "https://github.com/alexrudall/rails-ai-starter-kit/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "COMMERCIAL-LICENCE.txt", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 5"
  spec.add_dependency "pg", "~> 1.1"
  spec.add_dependency "ruby-openai", "~> 7.0.1"

  # Test
  spec.add_development_dependency "debug", "~> 1.9.2"
  spec.add_development_dependency "dotenv", "~> 3.1.0"
  spec.add_development_dependency "rspec-rails", "~> 6.1.2"
  spec.add_development_dependency "factory_bot_rails", "~> 6.4.3"
  spec.add_development_dependency "faker", "~> 3.3"
  spec.add_development_dependency "vcr", "~> 6.2.0"
  spec.add_development_dependency "webmock", "~> 3.23.0"

  # Lint
  spec.add_development_dependency "standard", "~> 1.35.1"
end

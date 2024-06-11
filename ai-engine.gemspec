require_relative "lib/ai/engine/version"

Gem::Specification.new do |spec|
  spec.name = "ai-engine"
  spec.version = AI::Engine::VERSION
  spec.authors = ["Alex Rudall"]
  spec.email = ["hello@alexrudall.com"]
  spec.homepage = "https://insertrobot.com/"
  spec.summary = "AI Engine is the easiest way to get advanced AI into your Rails app."
  spec.description = "A Rails Engine from the creator of ruby-openai."
  spec.license = "Nonstandard"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "http://get.keygen.sh"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://railsai.com/docs/ai-engine/"
  spec.metadata["changelog_uri"] = "https://ai-engine.insertrobot.com/"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "COMMERCIAL-LICENCE.txt", "Rakefile", "README.md"]
  end

  spec.required_ruby_version = ">= 3.0"

  spec.add_dependency "ruby-openai", "~> 7.1.0"

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

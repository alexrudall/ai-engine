require_relative "lib/ai/engine/version"

Gem::Specification.new do |spec|
  spec.name = "ai-engine"
  spec.version = AI::Engine::VERSION
  spec.authors = ["Alex Rudall"]
  spec.email = ["hello@alexrudall.com"]
  spec.homepage = "https://railsai.com/docs/installation"
  spec.summary = "The easiest way to get AI into your Rails app."
  spec.description = "A Rails Engine from the creator of ruby-openai."
  spec.license = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/alexrudall/ai-engine/"
  spec.metadata["changelog_uri"] = "https://github.com/alexrudall/ai-engine/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "Rakefile", "README.md"]
  end

  spec.required_ruby_version = ">= 3.0"

  spec.add_dependency "ruby-openai", "~> 7.1.0"
end

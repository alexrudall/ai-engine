require_relative "lib/ai/engine/version"

Gem::Specification.new do |spec|
  spec.name = "ai-engine"
  spec.version = AI::Engine::VERSION
  spec.authors = ["Alex Rudall"]
  spec.email = ["hello@alexrudall.com"]
  spec.homepage = "https://insertrobot.com/"
  spec.summary = "The easiest way to get AI into your Rails app."
  spec.description = "A Rails Engine from the creator of ruby-openai."
  spec.license = "Nonstandard"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "http://get.keygen.sh"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/alexrudall/ai-engine-starter-kit/"
  spec.metadata["changelog_uri"] = "https://github.com/alexrudall/ai-engine-starter-kit/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "COMMERCIAL-LICENCE.txt", "Rakefile", "README.md"]
  end

  spec.required_ruby_version = ">= 3.0"

  spec.add_dependency "ruby-openai", "~> 7.1.0"
end

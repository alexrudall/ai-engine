namespace :ai_engine do
  desc "Build and release a new version of the gem like so: `rake 'app:ai_engine:release[0.1.1]'`"
  task :release, [:version] => :environment do |t, args|
    version = args[:version]

    # Clean up the previous gem
    sh "rm -rf build"
    sh "mkdir -p build/gems"

    # Build the gem
    sh "gem build ai-engine.gemspec --output=build/gems/ai-engine-#{version}.gem"
    sh "gem generate_index --directory build/"

    # Tag the release in git
    sh "git tag v#{version}"
    sh "git push origin v#{version}"

    # Create a new version in Keygen
    sh "keygen new --version '#{version}'"

    # Upload the gem and build files to Keygen
    # 4.8 refers to the version of Marshal used, which is part of Ruby. More info: https://docs.ruby-lang.org/en/3.2/marshal_rdoc.html
    sh "keygen upload build/gems/ai-engine-#{version}.gem --filename 'gems/ai-engine-#{version}.gem' --release '#{version}'"
    %w[
      latest_specs.4.8
      latest_specs.4.8.gz
      prerelease_specs.4.8
      prerelease_specs.4.8.gz
      specs.4.8
      specs.4.8.gz
    ].each do |file|
      sh "keygen upload build/#{file} --filetype '' --release '#{version}'"
    end

    # Upload the quick gemspec to Keygen
    sh "keygen upload build/quick/Marshal.4.8/ai-engine-#{version}.gemspec.rz --filename 'quick/Marshal.4.8/ai-engine-#{version}.gemspec.rz' --release '#{version}'"

    # Publish the release in Keygen
    sh "keygen publish --release '#{version}'"
  end
end

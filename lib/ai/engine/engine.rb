module AI
  module Engine
    class Engine < ::Rails::Engine
      isolate_namespace AI::Engine

      class Configuration
        attr_accessor :openai_access_token, :openai_organization_id

        def initialize
          @openai_access_token = nil
          @openai_organization_id = nil
        end
      end

      config.generators do |g|
        g.test_framework :rspec
        g.fixture_replacement :factory_bot
        g.factory_bot dir: "spec/factories"
      end

      def self.setup(&block)
        @config ||= AI::Engine::Engine::Configuration.new

        yield @config if block

        @config
      end

      def self.config
        @config || self.setup
      end
    end
  end
end

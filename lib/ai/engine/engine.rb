module AI
  module Engine
    DOLLAR_COST_PER_1K_TOKENS = {
      "gpt-3.5-turbo" => {
        "input" => 0.0005,
        "output" => 0.0015
      },
      "gpt-4" => {
        "input" => 0.03,
        "output" => 0.06
      },
      "gpt-4-turbo" => {
        "input" => 0.01,
        "output" => 0.03
      },
      "gpt-4o" => {
        "input" => 0.005,
        "output" => 0.015
      }
    }.freeze
    MODEL_OPTIONS = DOLLAR_COST_PER_1K_TOKENS.keys.freeze

    def self.setup(&)
      Engine.setup(&)
    end

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
        @config || setup
      end
    end
  end
end

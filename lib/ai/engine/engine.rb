module AI
  module Engine
    class Engine < ::Rails::Engine
      isolate_namespace AI::Engine

      config.generators do |g|
        g.test_framework :rspec
      end
    end
  end
end

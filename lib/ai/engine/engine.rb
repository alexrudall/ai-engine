module AI
  module Engine
    class Engine < ::Rails::Engine
      isolate_namespace AI::Engine
    end
  end
end

module AI::Engine
  class Run < ApplicationRecord
    belongs_to :assistant, class_name: 'AI::Engine::Assistant'
  end
end

module AI::Engine
  class Run < ApplicationRecord
    belongs_to :assistant, class_name: 'AI::Engine::Assistant'
    has_many :messages, class_name: 'AI::Engine::Message', dependent: :nullify
  end
end

module AI::Engine
  class Chat < ApplicationRecord
    belongs_to :chattable, polymorphic: true
    has_many :runs, class_name: 'AI::Engine::Run', dependent: :nullify
    has_many :messages, class_name: 'AI::Engine::Message', dependent: :nullify
  end
end

module AI::Engine
  class Chat < ApplicationRecord
    belongs_to :assistable, polymorphic: true
    has_many :runs, class_name: 'AI::Engine::Run', dependent: :nullify
  end
end

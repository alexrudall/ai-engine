module AI::Engine
  class Message < ApplicationRecord
    belongs_to :chat, class_name: 'AI::Engine::Chat'
    belongs_to :run, class_name: 'AI::Engine::Run'

    enum role: {system: 0, assistant: 10, user: 20}
  end
end

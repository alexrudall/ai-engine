module AI
  module Engine
    module Chattable
      extend ActiveSupport::Concern

      included do
        has_many :chats, as: :chattable, class_name: "AI::Engine::Chat"
      end
    end
  end
end

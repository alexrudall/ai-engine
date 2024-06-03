module AI
  module Engine
    module Chattable
      extend ActiveSupport::Concern

      included do
        has_many :chats, as: :chattable, class_name: "AI::Engine::Chat"

        def on_ai_response(message:)
          # This is a hook for the AI Engine to notify the Chattable that a Message has been updated.
          # Override this method in your Chattable model to handle the event.
        end
      end
    end
  end
end

module AI
  module Engine
    module Chattable
      extend ActiveSupport::Concern

      included do
        has_many :chats, as: :chattable, class_name: "AI::Engine::Chat", dependent: :destroy

        def ai_engine_on_message_create(message:)
          # This is a hook for the AI Engine to notify the Chattable that a Message has been updated.
          # Override this method in your Chattable model to handle the event.
          Logger.new($stdout).info("ai_engine_on_message_create called - add `def ai_engine_on_message_create(message:)` to your Chattable model to handle this event.")
        end

        def ai_engine_on_message_update(message:)
          # This is a hook for the AI Engine to notify the Chattable that a Message has been updated.
          # Override this method in your Chattable model to handle the event.
          Logger.new($stdout).info("ai_engine_on_message_update called - add `def ai_engine_on_message_update(message:)` to your Chattable model to handle this event.")
        end
      end
    end
  end
end

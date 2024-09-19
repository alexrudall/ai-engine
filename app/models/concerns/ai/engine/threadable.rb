module AI
  module Engine
    module Threadable
      extend ActiveSupport::Concern

      included do
        has_many :assistant_threads, as: :threadable, class_name: "AI::Engine::AssistantThread", dependent: :nullify

        def ai_engine_on_message_create(message:)
          # This is a hook for the AI Engine to notify the AssistantThreadtable that a Message has been updated.
          # Override this method in your AssistantThreadtable model to handle the event.
          Logger.new($stdout).info("ai_engine_on_message_create called - add `def ai_engine_on_message_create(message:)` to your Threadable model to handle this event.")
        end

        def ai_engine_on_message_update(message:)
          # This is a hook for the AI Engine to notify the AssistantThreadtable that a Message has been updated.
          # Override this method in your AssistantThreadtable model to handle the event.
          Logger.new($stdout).info("ai_engine_on_message_update called - add `def ai_engine_on_message_update(message:)` to your Threadable model to handle this event.")
        end
      end
    end
  end
end

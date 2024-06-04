module AI
  module Engine
    module Chattable
      extend ActiveSupport::Concern

      included do
        has_many :assistant_threads, as: :chattable, class_name: "AI::Engine::AssistantThread"

        def on_ai_response(message:)
          # This is a hook for the AI Engine to notify the AssistantThreadtable that a Message has been updated.
          # Override this method in your AssistantThreadtable model to handle the event.
        end
      end
    end
  end
end

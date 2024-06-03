module AI
  module Engine
    module Assistable
      extend ActiveSupport::Concern

      included do
        has_one :assistant, as: :assistable, class_name: "AI::Engine::Assistant"

        before_create :create_openai_assistant

        # Default. Override in including model to customize.
        def ai_assistant
          {
            name: "Assistant for #{self.class.name} #{id}",
            model: AI::Engine::Assistant::MODEL_OPTIONS.first,
            description: "Assistant for #{self.class.name} #{id}",
            instructions: "Assistant for #{self.class.name} #{id}"
          }
        end

        private

        def create_openai_assistant
          build_assistant
          begin
            assistant.remote_id = AI::Engine::OpenAI::Assistants::Create.call(**ai_assistant)
          rescue Faraday::Error => e
            errors.add(:base, e.message)
            throw(:abort)
          end
        end
      end
    end
  end
end

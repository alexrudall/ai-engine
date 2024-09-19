module AI
  module Engine
    module Assistable
      extend ActiveSupport::Concern

      included do
        has_one :assistant, as: :assistable, class_name: "AI::Engine::Assistant", dependent: :destroy

        before_create :create_openai_assistant
        before_update :update_openai_assistant
        before_destroy :delete_openai_assistant

        # Default. Override in including model to customize.
        def ai_engine_assistant
          Logger.new($stdout).info("ai_engine_assistant called - add `def ai_engine_assistant` to your #{self.class.name} model to define the Assistant params. The method should return a Hash of: {name:, model:, description:, instructions:}.")
          {
            name: "Assistant for #{self.class.name} #{id}",
            model: AI::Engine::MODEL_OPTIONS.first,
            description: "Assistant for #{self.class.name} #{id}",
            instructions: "Assistant for #{self.class.name} #{id}"
          }
        end

        def ai_engine_run(assistant_thread:, content:)
          assistant_thread.run(assistant_id: assistant.id, content: content)
        end

        private

        def create_openai_assistant
          build_assistant
          begin
            assistant.remote_id = AI::Engine::OpenAI::Assistants::Create.call(ai_engine_assistant)
          rescue Faraday::Error => e
            errors.add(:base, e.message)
            throw(:abort)
          end
        end

        def update_openai_assistant
          AI::Engine::OpenAI::Assistants::Update.call(remote_id: assistant&.remote_id, parameters: ai_engine_assistant)
        rescue Faraday::Error => e
          errors.add(:base, e.message)
          throw(:abort)
        end

        def delete_openai_assistant
          AI::Engine::OpenAI::Assistants::Delete.call(remote_id: assistant&.remote_id)
        rescue Faraday::Error => e
          errors.add(:base, e.message)
          throw(:abort)
        end
      end
    end
  end
end

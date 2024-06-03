module AI::Engine
  class Chat < ApplicationRecord
    belongs_to :chattable, polymorphic: true
    has_many :runs, class_name: "AI::Engine::Run", foreign_key: "ai_engine_chat_id", dependent: :nullify
    has_many :messages, class_name: "AI::Engine::Message", foreign_key: "ai_engine_chat_id", dependent: :nullify

    before_create :create_openai_thread

    def run(assistant_id:, content:)
      # Create the request Message, locally and remotely on OpenAI.
      messages.create(content: content, role: "user")

      # Run the Thread using the selected Assistant.
      runs.create(ai_engine_assistant_id: assistant_id)
    end

    private

    def create_openai_thread
      self.remote_id = AI::Engine::OpenAI::Threads::Create.call
    rescue Faraday::Error => e
      errors.add(:base, e.message)
      throw(:abort)
    end
  end
end
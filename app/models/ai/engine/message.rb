module AI::Engine
  class Message < ApplicationRecord
    belongs_to :chat, class_name: "AI::Engine::Chat", foreign_key: "ai_engine_chat_id"
    belongs_to :run, class_name: "AI::Engine::Run", optional: true

    enum role: {system: 0, assistant: 10, user: 20}

    before_create :create_openai_message, unless: -> { assistant? } # Assistant messages on the OpenAI side are created by a Run.

    private

    def create_openai_message
      self.remote_id = AI::Engine::OpenAI::Messages::Create.call(thread_id: chat.remote_id, content: content, role: role)
    rescue Faraday::Error => e
      errors.add(:base, e.message)
      throw(:abort)
    end
  end
end

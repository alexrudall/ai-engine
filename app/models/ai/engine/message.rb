module AI::Engine
  class Message < ApplicationRecord
    belongs_to :chat, class_name: "AI::Engine::Chat", foreign_key: "ai_engine_chat_id"
    belongs_to :run, class_name: "AI::Engine::Run", foreign_key: "ai_engine_run_id", optional: true

    enum role: {system: 0, assistant: 10, user: 20}

    before_create :create_openai_message, unless: -> { assistant? } # Assistant messages on the OpenAI side are created by a Run.

    after_create_commit :on_create
    after_update_commit :on_ai_response, if: -> { assistant? }

    delegate :prompt_token_usage, to: :run, allow_nil: true
    delegate :completion_token_usage, to: :run, allow_nil: true

    def on_create
      chat.chattable.on_assistant_thread_message_create(message: self)
    end

    def on_ai_response
      chat.chattable.on_ai_response(message: self)
    end

    def to_partial_path
      "messages/message"
    end

    private

    def create_openai_message
      self.remote_id = AI::Engine::OpenAI::Messages::Create.call(thread_id: chat.remote_id, content: content, role: role)
    rescue Faraday::Error => e
      errors.add(:base, e.message)
      throw(:abort)
    end
  end
end

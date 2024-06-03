module AI::Engine
  class Run < ApplicationRecord
    belongs_to :assistant, class_name: "AI::Engine::Assistant", foreign_key: "ai_engine_assistant_id"
    belongs_to :chat, class_name: "AI::Engine::Chat", foreign_key: "ai_engine_chat_id"
    has_many :messages, class_name: "AI::Engine::Message", foreign_key: "ai_engine_chat_id", dependent: :nullify

    before_create :create_openai_run

    private

    def create_openai_run
      self.remote_id = AI::Engine::OpenAI::Runs::Create.call(
        assistant_id: assistant.remote_id,
        thread_id: chat.remote_id,
        stream: stream
      )
    rescue Faraday::Error => e
      errors.add(:base, e.message)
      throw(:abort)
    end

    def stream
      response_message = chat.messages.create(
        role: "assistant",
        content: ""
      )
      proc do |chunk, _bytesize|
        if chunk["object"] == "thread.message.delta"
          new_content = chunk.dig("delta", "content", 0, "text", "value")
          response_message.update(content: response_message.content + new_content) if new_content
        elsif chunk["status"] == "completed"
          self.remote_id = chunk["id"]
        end
      end
    end
  end
end

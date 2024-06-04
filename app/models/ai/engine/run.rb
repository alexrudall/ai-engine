module AI::Engine
  class Run < ApplicationRecord
    belongs_to :assistant, class_name: "AI::Engine::Assistant", foreign_key: "ai_engine_assistant_id"
    belongs_to :chat, class_name: "AI::Engine::Chat", foreign_key: "ai_engine_chat_id"
    has_many :messages, class_name: "AI::Engine::Message", foreign_key: "ai_engine_chat_id", dependent: :nullify

    after_create :create_openai_run

    def to_partial_path
      "runs/run"
    end

    private

    def create_openai_run
      AI::Engine::OpenAI::Runs::Create.call(
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
        ai_engine_run_id: id,
        role: "assistant",
        content: ""
      )
      proc do |chunk, _bytesize|
        if chunk["object"] == "thread.message.delta"
          new_content = chunk.dig("delta", "content", 0, "text", "value")
          response_message.update(content: response_message.content + new_content) if new_content
        elsif chunk["status"] == "completed"
          remote_run = AI::Engine::OpenAI::Runs::Retrieve.call(remote_id: chunk["run_id"], thread_id: chat.remote_id)
          if remote_run.present?
            assign_attributes(
              prompt_token_usage: remote_run&.dig("usage", "prompt_tokens"),
              completion_token_usage: remote_run.dig("usage", "completion_tokens")
            )
          end
          assign_attributes(remote_id: chunk["run_id"])
          save

          response_message.update(remote_id: chunk["id"]) # Do this at the end so that tokens can be fetched on the final message rerender.
        end
      end
    end
  end
end

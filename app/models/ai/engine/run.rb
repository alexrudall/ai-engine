module AI::Engine
  class Run < ApplicationRecord
    include AI::Engine::RemoteIdValidatable

    belongs_to :assistant, class_name: "AI::Engine::Assistant", foreign_key: "ai_engine_assistant_id"
    belongs_to :assistant_thread, class_name: "AI::Engine::AssistantThread", foreign_key: "ai_engine_assistant_thread_id"
    has_many :messages, class_name: "AI::Engine::Message", foreign_key: "ai_engine_run_id", dependent: :nullify

    after_create :create_openai_run

    def to_partial_path
      "runs/run"
    end

    private

    def create_openai_run
      AI::Engine::OpenAI::Runs::Create.call(
        assistant_id: assistant.remote_id,
        thread_id: assistant_thread.remote_id,
        stream: stream
      )
    rescue Faraday::Error => e
      errors.add(:base, e.message)
      throw(:abort)
    end

    def stream
      response_message = assistant_thread.messages.create(
        ai_engine_run_id: id,
        role: "assistant",
        content: ""
      )
      proc do |chunk, _bytesize|
        if chunk["object"] == "thread.message.delta"
          new_content = chunk.dig("delta", "content", 0, "text", "value")
          response_message.update(content: response_message.content + new_content) if new_content
        elsif chunk["status"] == "completed"
          if chunk["run_id"].present? && !remote_id.present?
            remote_run = AI::Engine::OpenAI::Runs::Retrieve.call(remote_id: chunk["run_id"], thread_id: assistant_thread.remote_id)
            if remote_run.present?
              assign_attributes(
                prompt_token_usage: remote_run&.dig("usage", "prompt_tokens"),
                completion_token_usage: remote_run.dig("usage", "completion_tokens")
              )
            end
            assign_attributes(remote_id: chunk["run_id"])
            save
          end

          if chunk["id"].present? && chunk["id"].start_with?(AI::Engine::Message.remote_id_prefix) && !response_message.remote_id.present?
            response_message.update(remote_id: chunk["id"])
          end
        end
      end
    end
  end
end

module AI::Engine
  class Chat < ApplicationRecord
    MODEL_OPTIONS = %w[
      gpt-3.5-turbo
      gpt-4
      gpt-4-turbo
      gpt-4o
    ].freeze

    belongs_to :chattable, polymorphic: true
    has_many :messages, as: :messagable, class_name: "AI::Engine::Message", foreign_key: "messagable_id", dependent: :nullify

    def run(model:)
      # Run the Chat, sending the complete message history to OpenAI.
      AI::Engine::OpenAI::Chats::Stream.call(chat_id: id, stream: stream(model: model), model: model)
    end

    def messages_for_openai
      messages.order(:created_at).map do |message|
        {
          role: message.role,
          content: message.content
        }
      end.filter { |message| message[:content].present? }
    end

    def stream(model:)
      response_message = messages.create(
        role: "assistant",
        content: "",
        model: model
      )

      proc do |chunk, _bytesize|
        if chunk["object"] == "chat.completion.chunk"
          new_content = chunk.dig("choices", 0, "delta", "content")
          response_message.update(content: response_message.content + new_content) if new_content
        end
        if chunk["usage"]
          response_message.update(
            prompt_token_usage: chunk.dig("usage", "prompt_tokens"),
            completion_token_usage: chunk.dig("usage", "completion_tokens")
          )
        end
      end
    end

    def to_partial_path
      "chats/chat"
    end
  end
end

module AI::Engine
  class Chat < ApplicationRecord
    belongs_to :chattable, polymorphic: true
    has_many :messages, as: :messagable, class_name: "AI::Engine::Message", foreign_key: "messagable_id", dependent: :nullify

    def run
      # Run the Chat, sending the complete message history to OpenAI.
      AI::Engine::OpenAI::Chats::Stream.call(chat_id: id, stream: stream)
    end

    def messages_for_openai
      messages.order(:created_at).map do |message|
        {
          role: message.role,
          content: message.content
        }
      end.filter { |message| message[:content].present? }
    end

    def stream
      response_message = messages.create(
        role: "assistant",
        content: ""
      )

      proc do |chunk, _bytesize|
        if chunk["object"] == "chat.completion.chunk"
          new_content = chunk.dig("choices", 0, "delta", "content")
          response_message.update(content: response_message.content + new_content) if new_content
        end
      end
    end

    def to_partial_path
      "chats/chat"
    end
  end
end

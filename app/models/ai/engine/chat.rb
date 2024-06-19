module AI::Engine
  class Chat < ApplicationRecord
    belongs_to :chattable, polymorphic: true
    has_many :messages, as: :messagable, class_name: "AI::Engine::Message", foreign_key: "messagable_id", dependent: :nullify

    def run(content:)
      # Create the request Message, locally.
      messages.create(content: content, role: "user")

      # Run the Chat, sending the complete message history to OpenAI.
      AI::Engine::Chat.call(chat_id: id)
    end

    def to_partial_path
      "chats/chat"
    end
  end
end

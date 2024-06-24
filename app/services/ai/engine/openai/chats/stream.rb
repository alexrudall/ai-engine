class AI::Engine::OpenAI::Chats::Stream
  # Gets the next message response to a set of messages.
  def self.call(chat_id:, stream:)
    chat = AI::Engine::Chat.find(chat_id)

    client.chat(
      parameters: {
        model: "gpt-4o",
        messages: chat.messages_for_openai,
        stream: stream
      }
    )
  end

  private_class_method def self.client
    @client ||= OpenAI::Client.new(
      access_token: AI::Engine::Engine.config.openai_access_token,
      organization_id: AI::Engine::Engine.config.openai_organization_id,
      log_errors: Rails.env.development? || Rails.env.test?,
      request_timeout: 2.minutes.to_i
    )
  end
end
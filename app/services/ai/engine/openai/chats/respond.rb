class AI::Engine::OpenAI::Chats::Respond
  # Gets the next message response to a set of messages.
  def self.call(chat_id:)
    response = client.messages.create(
      thread_id: thread_id,
      parameters: {
        content: content,
        role: role
      }
    )

    response["id"]
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
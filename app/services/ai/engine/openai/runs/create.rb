class AI::Engine::OpenAI::Runs::Create
  # Creates a new Run on the OpenAI API.
  def self.call(assistant_id:, thread_id:, stream: false)
    client.runs.create(
      thread_id: thread_id,
      parameters: {
        assistant_id: assistant_id,
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

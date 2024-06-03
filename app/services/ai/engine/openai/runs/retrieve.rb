class AI::Engine::OpenAI::Runs::Retrieve
  # Retrieves an OpenAI Run by its ID.
  def self.call(remote_id:, thread_id:)
    client.runs.retrieve(id: remote_id, thread_id: thread_id)
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

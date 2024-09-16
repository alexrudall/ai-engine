class AI::Engine::OpenAI::Assistants::Update
  # Updates an OpenAI Assistant with the given parameters.
  def self.call(remote_id:, parameters:)
    parameters = parameters.compact

    client.assistants.modify(
      id: remote_id,
      parameters: parameters
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

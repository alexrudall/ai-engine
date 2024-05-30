class AI::Engine::OpenAI::Assistants::Create
  # Creates a new Assistant on the OpenAI API.
  # Returns the OpenAI ID of the new Assistant.
  def self.call(name:, model:, description:, instructions:)
    response = client.assistants.create(
      parameters: {
        name: name,
        model: model,
        description: description,
        instructions: instructions
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

class AI::Engine::OpenAI::Threads::Delete
  # Deletes an OpenAI Thread by its ID.
  def self.call(remote_id:)
    response = client.threads.delete(id: remote_id)

    response["id"]
  rescue Faraday::ResourceNotFound => e
    Rails.logger.error("#{self} - #{e.response.dig(:body, "error", "message")}")
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

class OpenAI::Assistants::Update
  # Updates an OpenAI Assistant with the given parameters.
  def self.call(remote_id:, name: nil, model: nil, description: nil, instructions: nil)
    parameters = {
      name: name,
      model: model,
      description: description,
      instructions: instructions
    }.compact

    OpenAI::Client.new.assistants.modify(
      id: remote_id,
      parameters: parameters
    )
  end
end

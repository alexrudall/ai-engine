class OpenAI::Assistants::Create
  # Gets the OpenAI ID of a new Assistant.
  def self.call(name:, model:, description:, instructions:)
    response = OpenAI::Client.new.assistants.create(
      parameters: {
        name: name,
        model: model,
        description: description,
        instructions: instructions
      }
    )

    response["id"]
  end
end

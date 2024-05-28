class OpenAI::Assistants::Retrieve
  # Fetches an OpenAI Assistant with the given remote_id.
  def self.call(remote_id:)
    OpenAI::Client.new.assistants.retrieve(id: remote_id)
  end
end

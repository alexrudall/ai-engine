module AI::Engine
  class OpenAI::Threads::Create
    # Gets the OpenAI ID of a new Thread.
    def self.call
      response = OpenAI::Client.new.threads.create(parameters: {})

      response["id"]
    end
  end
end

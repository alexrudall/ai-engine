class CreateMessageAndRun < SidekiqJob
  def perform(message_id)
    message = Message.find(message_id)

    create_message(message:)

    case message.chat.assistable_type
    when "Assistant"
      run_assistant(chat: message.chat, assistant: message.chat.assistable)
    when "Pipeline"
      run_pipeline(chat: message.chat, pipeline: message.chat.assistable)
    end
  end

  private

  def create_message(message:)
    remote_id = OpenAI::Client.new.messages.create(
      thread_id: message.chat.remote_id,
      parameters: {
        content: message.content,
        role: message.role
      }
    )["id"]
    message.update(remote_id: remote_id)
  end

  def run_assistant(chat:, assistant:)
    OpenAI::Client.new.runs.create(
      thread_id: chat.remote_id,
      parameters: {
        assistant_id: assistant.remote_id,
        max_prompt_tokens: assistant.max_prompt_tokens,
        max_completion_tokens: assistant.max_completion_tokens,
        stream: stream(chat:, assistant:)
      }
    )
  end

  def run_pipeline(chat:, pipeline:)
    pipeline.pipeline_assistants.includes(:assistant).rank(:row_order).each do |pa|
      run_assistant(chat: chat, assistant: pa.assistant)
    end
  end

  def stream(chat:, assistant:)
    new_message = chat.messages.create(
      user: User.system,
      assistant: assistant,
      role: "assistant",
      content: ""
    )
    new_message.broadcast_created
    proc do |chunk, _bytesize|
      if chunk["object"] == "thread.message.delta"
        new_content = chunk.dig("delta", "content", 0, "text", "value")
        new_message.update(content: new_message.content + new_content) if new_content
      end
    end
  end
end

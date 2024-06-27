module AI::Engine
  class Message < ApplicationRecord
    include RemoteIdValidatable

    belongs_to :messageable, polymorphic: true # AI::Engine::Chat or AI::Engine::AssistantThread
    belongs_to :run, class_name: "AI::Engine::Run", foreign_key: "ai_engine_run_id", optional: true

    enum role: {system: 0, assistant: 10, user: 20}

    before_create :create_openai_message,
      if: -> { in_assistant_thread? }, # Chat messages are only stored locally.
      unless: -> { assistant? } # Checking the role - assistant messages on the OpenAI side are created by a Run.
    after_create :on_create
    after_update :on_update

    def user
      in_chat? ? messageable.chattable : messageable.threadable
    end

    def in_chat?
      messageable.is_a?(AI::Engine::Chat)
    end

    def in_assistant_thread?
      messageable.is_a?(AI::Engine::AssistantThread)
    end

    def on_create
      if in_chat?
        messageable.chattable.ai_engine_on_message_create(message: self)
      else
        messageable.threadable.ai_engine_on_message_create(message: self)
      end
    end

    def on_update
      if in_chat?
        messageable.chattable.ai_engine_on_message_update(message: self)
      else
        messageable.threadable.ai_engine_on_message_update(message: self)
      end
    end

    def to_partial_path
      "messages/message"
    end

    private

    def create_openai_message
      self.remote_id = AI::Engine::OpenAI::Messages::Create.call(thread_id: messageable.remote_id, content: content, role: role)
    rescue Faraday::Error => e
      errors.add(:base, e.message)
      throw(:abort)
    end
  end
end

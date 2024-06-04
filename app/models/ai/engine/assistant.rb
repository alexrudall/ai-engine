module AI::Engine
  class Assistant < ApplicationRecord
    include RemoteIdValidatable

    belongs_to :assistable, polymorphic: true
    has_many :runs, class_name: "AI::Engine::Run", foreign_key: "ai_engine_assistant_id", dependent: :nullify

    def to_partial_path
      "assistants/assistant"
    end

    MIN_PROMPT_TOKENS = 256
    MIN_COMPLETION_TOKENS = 16
    MODEL_OPTIONS = %w[
      gpt-3.5-turbo
      gpt-4
      gpt-4-turbo
      gpt-4o
    ].freeze
  end
end

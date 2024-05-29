module AI::Engine
  class Assistant < ApplicationRecord
    # has_many :messages, dependent: :nullify

    MIN_PROMPT_TOKENS = 256
    MIN_COMPLETION_TOKENS = 16
  end
end

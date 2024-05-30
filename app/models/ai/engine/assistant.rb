module AI::Engine
  class Assistant < ApplicationRecord
    belongs_to :assistable, polymorphic: true

    MIN_PROMPT_TOKENS = 256
    MIN_COMPLETION_TOKENS = 16
  end
end

class Assistant < ApplicationRecord
  include Nameable
  include AI::Engine::Assistable

  has_many :user_assistables, as: :assistable, dependent: :destroy
  has_many :users, through: :user_assistables
  has_many :chats, as: :assistable, dependent: :nullify
  has_many :messages, dependent: :nullify

  MIN_PROMPT_TOKENS = 256
  MIN_COMPLETION_TOKENS = 16
end

class Storyteller < ApplicationRecord
  include AI::Engine::Assistable

  belongs_to :user
  has_many :messages, dependent: :nullify
end

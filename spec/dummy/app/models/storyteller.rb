class Storyteller < ApplicationRecord
  include AI::Engine::Assistable

  belongs_to :user
  has_many :messages, dependent: :nullify

  def ai_assistant
    {
      name: name,
      model: model,
      description: name,
      instructions: instructions
    }
  end
end

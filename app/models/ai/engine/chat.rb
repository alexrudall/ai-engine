module AI::Engine
  class Chat < ApplicationRecord
    belongs_to :chattable, polymorphic: true
    has_many :runs, class_name: "AI::Engine::Run", dependent: :nullify
    has_many :messages, class_name: "AI::Engine::Message", dependent: :nullify

    before_create :create_openai_thread

    private

    def create_openai_thread
      self.remote_id = AI::Engine::OpenAI::Threads::Create.call
    rescue Faraday::Error => e
      errors.add(:base, e.message)
      throw(:abort)
    end
  end
end

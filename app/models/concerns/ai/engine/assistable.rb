module AI
  module Engine
    module Assistable
      extend ActiveSupport::Concern

      included do
        has_one :assistant, as: :assistable, class_name: 'AI::Engine::Assistant'
      end
    end
  end
end

Rails.application.routes.draw do
  mount AI::Engine::Engine => "/test-engine"
end

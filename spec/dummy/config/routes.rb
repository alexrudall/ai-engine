Rails.application.routes.draw do
  mount AI::Engine::Engine => "/ai-engine"
end

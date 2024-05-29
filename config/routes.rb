AI::Engine::Engine.routes.draw do
  resources :assistants

  root to: "assistants#index"
end

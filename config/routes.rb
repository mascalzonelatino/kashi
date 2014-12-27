Kashi::Application.routes.draw do
  root 'home#index'

  resources :songs, only: [:index, :show]
end


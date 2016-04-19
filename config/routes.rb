Rails.application.routes.draw do
  root to: "states#index"
  resources :states, only: [:new]
end

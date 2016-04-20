Rails.application.routes.draw do
  root to: "states#index"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :summaries, only: [:index, :show], module: "summaries"
    end
  end
end

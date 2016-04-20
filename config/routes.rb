Rails.application.routes.draw do
  root to: "states#index"

  get "/states", to: "states#show"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :summaries, only: [:index], module: "summaries" do
        collection do
          get "/find", to: "summaries#show"
        end
      end
    end
  end
end

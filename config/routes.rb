Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  get "up" => "rails/health#show", as: :rails_health_check
  get "test", to: "test#index"

  namespace :api do
    namespace :v1 do
      namespace :user do
        resource :sessions, only: [:create]
      end
    end
  end
end

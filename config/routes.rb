Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  get "up" => "rails/health#show", as: :rails_health_check
  get "test", to: "test#index"

  namespace :api, format: :json do
    namespace :v1 do
      namespace :users do
        resources :progoses, only: %i(create index show update destroy)

        scope "/sessions" do     
          post :sign_in, to: "sessions#create"
          delete :sign_out, to: "sessions#destroy"
        end
      end
    end
  end
end

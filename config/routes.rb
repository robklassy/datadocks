Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  resources :customers, only: [:index, :show]

  resources :reservations, only: [:index, :show, :create]

  resources :restaurants, only: [:index, :show] do
    resources :reservations, only: [:index, :show]
    resources :tables, only: [:index, :show]
  end

  resources :servers, only: [:index, :show]

  resources :tables, only: [:index, :show, :occupied] do
    collection do
      get 'occupied'
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end

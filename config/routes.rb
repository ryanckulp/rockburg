Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :bands do
    resources :activities
    resources :skills do
      resources :members do
        member do
          get 'hire'
        end
      end
    end
  end
  resources :members
  resources :skills

  devise_for :managers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "managers#index"


end

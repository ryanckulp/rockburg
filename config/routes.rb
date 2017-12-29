Rails.application.routes.draw do
  resources :bands do
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

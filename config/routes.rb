Rails.application.routes.draw do
  resources :recipes do
    resource :favorites, only: [:create, :destroy]
  end
  resource :user, except: [:new, :create, :destroy]
  devise_for :users
  root to: "home#index"
end

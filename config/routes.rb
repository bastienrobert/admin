Rails.application.routes.draw do
  resources :periods

  devise_for :users
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  resources :users
  get '/users/:id/periods' => "users#periods", as: :periods_user

  get '/dashboard' => "dashboard#index", as: :user_root
end

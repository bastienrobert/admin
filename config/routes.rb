Rails.application.routes.draw do
  resources :periods
  devise_for :users
  devise_scope :user do
    root to: "devise/sessions#new"
  end
  get '/dashboard' => "application#index", as: :user_root
end

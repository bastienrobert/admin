Rails.application.routes.draw do
  resources :periods, except: [:new] do
    collection do
      get 'new/:user_id', :to => "periods#new", :as => 'new'
      post 'status/(:token)', :to => "periods#order_status", :as => 'order_status'
      post 'refund/(:token)', :to => "periods#order_refund", :as => 'order_refund'
      post 'tracking/(:token)', :to => "periods#order_tracking", :as => 'order_tracking'
      post 'message/(:token)', :to => "periods#send_comment", :as => 'send_comment'
    end
  end

  devise_for :users
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  resources :users

  get '/dashboard' => "dashboard#index", as: :user_root
  get '/order/:id' => "dashboard#order", as: :order_dashboard
end

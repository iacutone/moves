Moves::Application.routes.draw do
  resources :users do
    member do
      post   "/activity", :to => "users#activity"
    end
  end
  root :to => 'users#new'

  post   "/auth/:provider/callback", :to => "sessions#create"
  get    "/auth/:provider/callback", :to => "sessions#create"
  delete "/signout" => "sessions#destroy", :as => :signout
end

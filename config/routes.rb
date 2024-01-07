Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  scope :api do
    # articles routes
    resources :articles do
      get "/feed", to: "articles#feed", on: :collection
    end
    # users routes
    scope :users do
      post "/", to: "users#create"
      post "/login", to: "users#login"
    end
  end
end

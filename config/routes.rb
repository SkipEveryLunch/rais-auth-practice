Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  # root "articles#index"
  post 'authenticate', to: 'authentication#create'
  get 'hello', to: 'hello#hello'
end

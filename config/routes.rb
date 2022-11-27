Rails.application.routes.draw do
  root 'calculator#input'
  post '/result', to: 'calculator#result'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

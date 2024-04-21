Rails.application.routes.draw do
  devise_for :users
  resources :books
  resources :users, except: %i[destroy new create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # Defines the root path route ("/")
  # root "articles#index"
end

Rails.application.routes.draw do
  resources :users
  post "/login", to: "users#login"
  # resources :tasks
  # resources :items
  resources :tasks do 
    #member do                    #collection do -> /tasks/items/..
      resources :items
    #end
  end
end

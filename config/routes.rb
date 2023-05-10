Rails.application.routes.draw do
  namespace :api do         
    namespace :v1 do
      resources :users
      post '/login', to: 'users#login'
      resources :reservations
      resources :tutors

    end
  end
end

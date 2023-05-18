Rails.application.routes.draw do
  namespace :api do         
    namespace :v1 do
      resources :users, only: %i[create]
      post '/login', to: 'users#login'
      resources :reservations, only: %i[index create]
      resources :tutors
    end
  end
end

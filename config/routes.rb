Rails.application.routes.draw do
  resources :reservations
  namespace :api do         
    namespace :v1 do
      resources :users
      resources :reservations
      resources :tutors
    end
  end
end

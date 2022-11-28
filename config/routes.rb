Rails.application.routes.draw do
   
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :users
  namespace :api do
    namespace :v1 do
      resources :fitness_activities, only: %i[index show create destroy update]
    end
  end
end

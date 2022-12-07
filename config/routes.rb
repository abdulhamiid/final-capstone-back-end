Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post :auth, to: 'authentication#create'
      resources :users
      resources :reservations, only: [:index]
      resources :fitness_activities, only: %i[index show create destroy update] do
        resources :reservations, only: %i[index show create destroy]
        resources :available_dates, only: [:index]
      end
    end
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end

Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }, path: '', path_names: { sign_in: 'login', sign_out: 'logout', registration: 'signup' },                                                  
                     controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  namespace :api do
    namespace :v1 do
      resources :posts, only: %i[create]
      resources :users do
        collection do
          get :current_user_data
        end
      end
      resources :posts, only: %i[index update destroy show] do
        resources :likes, only: %i[create update destroy show]
      end
      resources :comments, only: %i[index create update destroy show] do
        resources :likes, only: %i[create update destroy show]
      end
    end
  end
end

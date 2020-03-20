Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users

  # Dev environment hacking on the homepage
  root to: 'homepage#homepage'

  # Non API Routes
  resources :homepage
  resources :profiles
  resources :discover
  resources :groups
  resources :updates
  get "/episodes", to: "updates#index"

  get '/podcasts/:id', to: 'api/v1/podcasts#show'
  get '/collections', to: 'collections#index'

  namespace :api, path: '/', defaults: { format: 'json' } do

    # V1 API Routes
    namespace :v1 do

      # UserPodcastStatus / User's Library
      post '/my_library', to: 'my_library#create'
      get '/all_library', to: 'my_library#all_library'
      get '/my_library', to: 'my_library#status_for_podcast_and_user'
      get '/remove_from_my_library', to: 'my_library#delete_status_for_podcast_and_user'

      # Search routes
      get '/search', to: 'search#search'
      resources :search

      resources :welcome
      resources :podcasts
      resources :updates

    end
  end
end

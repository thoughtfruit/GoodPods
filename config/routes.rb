Rails.application.routes.draw do
  devise_for :users

  # Production
  # root to: 'welcome#welcome'
  #
  #
  # Dev environment hacking on the homepage
  root to: 'homepage#homepage'

  get '/search', to: 'search#search'
  resources :search
  resources :homepage
  resources :profiles
  resources :discover
  resources :groups

  namespace :v1,
    path: "/",
    defaults: { format: 'json' } do

    post '/my_library', to: 'my_library#create'
    get '/my_library', to: 'my_library#status_for_podcast_and_user'
    get '/remove_from_my_library', to: 'my_library#delete_status_for_podcast_and_user'
    get '/all_library', to: 'my_library#all_library'

    resources :podcasts
    resources :updates
  end
end

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

  namespace :v1,
    path: "/",
    defaults: { format: 'json' } do

    resources :podcasts
    resources :updates
  end
end

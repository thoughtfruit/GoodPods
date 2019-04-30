Rails.application.routes.draw do
  devise_for :users

  # Production
  # root to: 'welcome#welcome'
  #
  #
  # Dev environment hacking on the homepage
  root to: 'homepage#homepage'

  resources :homepage

  namespace :v1,
    path: "/",
    defaults: { format: 'json' } do

    resources :podcasts
  end
end

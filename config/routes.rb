Rails.application.routes.draw do
  root to: 'welcome#welcome'

  namespace :v1,
    path: "/",
    defaults: { format: 'json' } do

    resources :podcasts
  end
end

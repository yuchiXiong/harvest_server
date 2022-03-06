Rails.application.routes.draw do
  resources :bills, only: %i[index create]
  namespace :user do
    resource :sessions
  end
end

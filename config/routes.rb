Rails.application.routes.draw do

  resources :bills, only: :index
  namespace :user do
    resource :sessions
  end

end

Rails.application.routes.draw do

  resources :bills, only: [:index, :create]
  namespace :user do
    resource :sessions
  end

end

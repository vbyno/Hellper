Hellper::Application.routes.draw do
  root 'tickets#new'
  resources :tickets, only: [:new, :create, :show]

  devise_for :staff
  namespace :staff do
    resources :tickets, only: [:index, :edit, :update]
  end
end

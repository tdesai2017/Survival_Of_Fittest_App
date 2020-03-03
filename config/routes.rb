Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :boards
  get '/boards/:id/next_state', to: 'boards#next_state', as: :next_state
  get '/boards/:id/restart_state', to: 'boards#restart_state', as: :restart_state



  get '/boards/:id/flip_cell', to: 'boards#flip_cell', as: :flip_cell




end

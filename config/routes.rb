Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :boards
  get '/boards/:id/next_state', to: 'boards#next_state'
  get '/boards/:id/restart_state', to: 'boards#restart_state'



end

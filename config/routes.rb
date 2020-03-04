Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :boards
  post '/boards/:id/next_state', to: 'boards#next_state', as: :next_state
  post '/boards/:id/restart_state', to: 'boards#restart_state', as: :restart_state
  post '/boards/:id/flip_cell', to: 'boards#flip_cell', as: :flip_cell
  post '/boards/:id/add_row', to: 'boards#add_row', as: :add_row
  post '/boards/:id/add_col', to: 'boards#add_col', as: :add_col
  post '/boards/:id/remove_col', to: 'boards#remove_col', as: :remove_col
  post '/boards/:id/remove_row', to: 'boards#remove_row', as: :remove_row
  post '/boards/:id/save_as_initial_state', to: 'boards#save_as_initial_state', as: :save_as_initial_state



end

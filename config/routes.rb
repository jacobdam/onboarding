Rails.application.routes.draw do
  devise_for :users, controllers: { invitations: 'users/invitations' }
  root to: 'homes#index'
  resource :company, only: %i{new create edit update}
  resource :dashboard, only: %i{show}
  resources :mentors, only: [:show, :index]
  resources :mentees
end

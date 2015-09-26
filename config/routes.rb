Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#index'
  resource :company, only: %i{new create edit update}
  resource :dashboard, only: %i{show}
end

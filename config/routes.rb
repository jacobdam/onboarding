Rails.application.routes.draw do
  devise_for :users, controllers: { invitations: 'users/invitations' }
  root to: 'homes#index'
  resource :company, only: %i{new create edit update}
  resource :dashboard, only: %i{show}
  resources :mentors, only: %i(index show)

  resources :mentees do
    resources :check_points do
      member do
        post :finish
        get :question
        post :answer
      end
    end
  end
end

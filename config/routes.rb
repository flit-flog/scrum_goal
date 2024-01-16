Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  
  resources :teams do
    resource :team_users, only: [:create, :destroy]
    resources :diaries
  end
  
  
  post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
end

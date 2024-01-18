Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  
  resources :users
  get "users/:id/my_team" => "users#my_team", as: :my_team
  
  resources :teams do
    resources :diaries do
      resources :favorites, only: [:create, :destroy, :index]
      resources :diary_comments, only: [:create, :destroy]
    end
    resource :team_users, only: [:create, :destroy]
    resource :permits, only: [:create, :destroy]
  end
  
  get "teams/:id/permits" => "teams#permits", as: :permits
  post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
end

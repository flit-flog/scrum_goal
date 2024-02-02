Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  
  resources :users, only: [:show, :edit, :update, :destroy]
  get "users/:id/my_team" => "users#my_team", as: :my_team
  
  resources :diaries, only: [:new, :create, :show, :edit, :update, :destroy] do
      resources :favorites, only: [:create, :destroy]
      resources :diary_comments, only: [:create, :destroy, :update]
  end
  get "diaries/:id/favoritede_user" => "diaries#favorite", as: :favorited_user

  
  resources :teams, only: [:new, :create, :show, :edit, :update, :destroy]do
    resource :team_users, only: [:create, :destroy]
    get "permits" => "teams#permits", as: :permits
    get "members" => "teams#members", as: :members
    delete "members" => "team_users#banishment", as: :banishment

    delete 'permits/refuse_permit' => 'permits#refuse_permit', as: :refuse_permit
    resource :permits, only: [:create, :destroy]
  end
  
  get "/search" => "searches#search_teams"
  post '/homes/guest_sign_in'=> 'homes#guest_sign_in'
end

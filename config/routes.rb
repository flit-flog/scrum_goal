Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  
  
  resources :teams do
    resources :diaries
    resource :team_users, only: [:create, :destroy]
    resource :permits, only: [:create, :destroy]
  end
  
  get "teams/:id/permits" => "teams#permits", as: :permits
  post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
end

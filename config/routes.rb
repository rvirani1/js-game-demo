Rails.application.routes.draw do
  devise_for :users

  get "hangmen/challenge" => "hangmen#new_challenge", as: :new_challenge
  post "hangmen/challenge" => "hangmen#create_challenge", as: :create_challenge
  get "hangmen/answer/:id" => "hangmen#answer", as: :answer

  resources :hangmen, only: [:index, :show, :create, :update] do
    get 'hint', on: :member
  end

  get "angular/test" => "angular#test"
  root to: "static_pages#home"

end

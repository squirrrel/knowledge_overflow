Rails.application.routes.draw do
  devise_for :users, skip: [:sessions]
    as :user do
      get '/users/sign_in' => 'sessions#new', as: 'new_user_session'
      post '/users/sign_in' => 'sessions#create', as: 'user_session'
      delete '/users/sign_out' => 'sessions#destroy', as: 'destroy_user_session'
    end

  resources :users

  root 'questions#index'

  concern :votable do
    get :vote, on: :member
  end

  resources :answers, concerns: :votable

  resources :questions, concerns: :votable do
    get :tagged, on: :collection, to: :index
  end

  scope :api, constraints: { format: :json } do
    resources :questions, :answers, only: [:index, :show]
  end
end

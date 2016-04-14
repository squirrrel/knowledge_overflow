Rails.application.routes.draw do
  devise_for :users
  resources :users

  root 'questions#index'

  concern :votable do
    get :vote, on: :member
  end

  resources :answers, concerns: :votable

  resources :questions, concerns: :votable do
    get :tagged, on: :collection
  end
end

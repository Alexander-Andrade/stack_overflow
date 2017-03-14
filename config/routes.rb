Rails.application.routes.draw do
  root 'questions#index'

  resources :questions, only: [:index, :show, :new, :create]
  resources :answers, only: [:new, :create]

end

Rails.application.routes.draw do
  root 'questions#index'

  resources :questions, only: [:index, :show, :new, :create] do
    resources :answers, only: [:new, :create]
  end
end

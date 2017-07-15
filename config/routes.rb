Rails.application.routes.draw do
  get 'attachments/destroy'

  devise_for :users
  root 'questions#index'

  resources :questions do
    resources :answers,  shallow: true do
      member do
        post :set_best
      end
    end
  end

  resources :attachments, only: [:destroy]
end

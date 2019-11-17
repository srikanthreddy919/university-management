Rails.application.routes.draw do
  devise_for :users, only: [:sessions]
  devise_scope :user do
    get "/" => "devise/sessions#new"
  end

  # student namespace
  namespace :student do
    resources :courses, only: [:index, :show] do
      member do
        post :apply
      end
    end
  end

  #teacher namespace
  namespace :teacher do
    resources :courses
  end

  #admin namespace
  namespace :admin do
    resources :class_rooms
  end
end

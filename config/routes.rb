Rails.application.routes.draw do

  root to: "public/homes#top"
  get '/about' => 'public/homes#about', as: 'about'

  devise_for :end_users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :public do
    resources :posts
    resources :hot_springs, only: [:index, :show]
    resources :end_users, only: [:show, :edit, :update] do
      member do
        get 'withdrawal'
        patch 'update_withdrawal'
      end
    end
  end
  
  namespace :admin do
    get '' => 'homes#top', as: 'top'
    resources :end_users, only:[:show, :edit, :update]
    resources :posts, only:[:index, :show, :destroy]
    resources :hot_springs, only:[:index, :show, :create, :edit, :update, :destroy]
    resources :posts, only:[:index, :edit, :update]
    resources :genres, only:[:index, :create, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

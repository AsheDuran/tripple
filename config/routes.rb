Rails.application.routes.draw do

  devise_for :end_users, path: :public, skip: [:passwords], controllers: {#skipオプションで不要なルーティングを削除
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }#生成したコントローラーがどこに存在するかを記述

  devise_scope :end_user do#guest_sign_in機能の際追加
    post 'end_users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  devise_for :admins, skip: [:registrations, :passwords], controllers: {#skipオプションで不要なルーティングを削除
    sessions: "admin/sessions"
  }#生成したコントローラーがどこに存在するかを記述

  root to: "homes#top"
  get "home/derivation"=>"homes#derivation", as: "derivation"
  get "home/outline"=>"homes#outline", as: "outline"

  namespace :public do
    get '/end_users/unsubscribe' => 'end_users#unsubscribe', as: 'unsubscribe'
    patch '/end_users/withdraw' => 'end_users#withdraw', as: 'withdraw'
    resources :spots do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    get "search" => "spots#search"
    resources :prefectures
    resources :genres
    resources :end_users do#controllerでmy_pageを定義したからdo-endの間にget :my_page, on: :collectionを記述
      get :my_page, on: :collection
      get :favorites
    end
  end

  namespace :admin do
    resources :end_users
    resources :spots do
      resource :favorites, only:[:create, :destroy]
      resources :comments, only: [:destroy]
    end
    get "search" => "spots#search"
    resources :genres
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

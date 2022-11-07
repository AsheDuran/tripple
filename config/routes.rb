Rails.application.routes.draw do


  devise_for :end_users, path: :public, skip: [:passwords], controllers: {#skipオプションで不要なルーティングを削除
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }#生成したコントローラーがどこに存在するかを記述

  devise_for :admins, skip: [:registrations, :passwords], controllers: {#skipオプションで不要なルーティングを削除
    sessions: "admin/sessions"
  }#生成したコントローラーがどこに存在するかを記述

  root to: "homes#top"
  get "home/derivation"=>"homes#derivation", as: "derivation"
  get "home/outline"=>"homes#outline", as: "outline"

  namespace :public do
    resources :spots
    resources :prefectures
    resources :genres
    get "end_users/my_page" => "end_users#my_page", as: "my_page"
    resources :end_users
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

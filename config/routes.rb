Rails.application.routes.draw do

  devise_for :end_users, skip: [:passwords], controllers: {#skipオプションで不要なルーティングを削除
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }#生成したコントローラーがどこに存在するかを記述

  devise_for :admins, skip: [:registrations, :passwords], controllers: {#skipオプションで不要なルーティングを削除
    sessions: "admin/sessions"
  }#生成したコントローラーがどこに存在するかを記述

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

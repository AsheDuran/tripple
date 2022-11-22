class Public::EndUsersController < ApplicationController
 before_action :authenticate_end_user!
 #before_action :ensure_guest_end_user, only: [:edit]

 def show
   @end_user = EndUser.find(params[:id])
   #byebug
   if @end_user.id == current_end_user.id#自分だったら、全投稿が表示される。
     @spots = @end_user.spots
   else
     @spots = @end_user.spots.published
   end
 end

 def my_page#showでcurrent_end_userを使用したら、ややこしかったので、こっちに記述した。
   @end_user = current_end_user
   @spots = @end_user.spots
   render :show#本当はshowページに記載するため、render先はshow
 end

 def edit
    @end_user = current_end_user
 end

 def update
   @end_user = current_end_user
   if @end_user.update(end_user_params)
     flash[:notice] = "編集が完了しました!"
     redirect_to my_page_public_end_users_path
   else  flash[:notice] = "編集に失敗しました..."
     render :edit
   end
 end

 def unsubscribe
   @end_user = current_end_user
 end

 def withdraw
   @end_user = current_end_user
   # is_deletedカラムをtrueに変更することにより削除フラグを立てる
   @end_user.update(is_deleted: true)
   reset_session
   redirect_to root_path
 end

 def favorites
   @end_user = current_end_user
   favorites= Favorite.where(end_user_id: @end_user.id).pluck(:spot_id)
   #エンドユーザーidが、このエンドユーザーの、いいねのレコードを全て取得して、そのspot_idも一緒に持ってくる。それをfavoritesに代入。
   #where:与えられた条件にマッチするレコードを全て取得。
   @favorite_spots = Spot.find(favorites)
 end

 # def ensure_guest_end_user
 #   @end_user = EndUser.find(params[:id])
 #   if @end_user.(first_name+last_name) == ("サンプル"+"太郎")
 #     redirect_to my_page_public_end_users_path(current_end_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
 #   end
 # end

 private

 def end_user_params
  params.require(:end_user).permit(:last_name, :first_name, :introduction, :profile_image)
 end

end

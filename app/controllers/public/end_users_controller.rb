class Public::EndUsersController < ApplicationController

 def show
   @end_user = EndUser.find(params[:id])
   #byebug
   @spots = @end_user.spots
 end

 def my_page#showでcurrent_end_user使ったら、ややこしかったので、こっちに記述した。
   @end_user = current_end_user
   @spots = @end_user.spots
   render :show#本当はshowページに記載するため、render先はshow
 end#この後、routes.rbに記述

 def edit
    @end_user = current_end_user
 end

 def update
   @end_user = current_end_user
   @end_user.update(end_user_params)
   redirect_to my_page_public_end_users_path
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


 private

 def end_user_params
  params.require(:end_user).permit(:last_name, :first_name, :introduction, :profile_image)
 end

end

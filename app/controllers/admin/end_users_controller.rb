class Admin::EndUsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @end_users = EndUser.all
  end

  def show
    @end_user = EndUser.find(params[:id])
    @spots = @end_user.spots

  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
   @end_user = EndUser.find(params[:id])
   @end_user.update(end_user_params)
   redirect_to admin_end_users_path
  end

 private

 def end_user_params
  params.require(:end_user).permit(:last_name, :first_name, :introduction, :profile_image, :is_deleted)
 end

end

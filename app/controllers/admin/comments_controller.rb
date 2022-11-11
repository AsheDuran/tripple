class Admin::CommentsController < ApplicationController


  def destroy
    Comment.find_by(id: params[:id],spot_id: params[:spot_id]).destroy
    #byebug
    redirect_to admin_spots_path
  end
end

class Admin::CommentsController < ApplicationController


  def destroy
    spot = Spot.find(params[:spot_id])
    Comment.find_by(id: params[:id],spot_id: params[:spot_id]).destroy
    #byebug
    redirect_to admin_spot_path(spot)
  end
end

class Public::CommentsController < ApplicationController

  def create
    spot = Spot.find(params[:spot_id])
    comment = current_end_user.comments.new(comment_params)
    comment.spot_id = spot.id
    comment.save
    redirect_to public_spot_path(spot)
  end

  def destroy
    spot = Spot.find(params[:spot_id])
    Comment.find_by(id: params[:id],spot_id: params[:spot_id]).destroy
    redirect_to public_spot_path(spot)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end

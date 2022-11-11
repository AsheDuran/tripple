class Public::FavoritesController < ApplicationController

  def create
    spot = Spot.find(params[:spot_id])
    favorite = current_end_user.favorites.new(spot_id: spot.id)
    favorite.save
    #logger.debug("いいね成功！")
    redirect_to public_spot_path(spot)
  end

  def destroy
    spot = Spot.find(params[:spot_id])
    favorite = current_end_user.favorites.find_by(spot_id: spot.id)
    favorite.destroy
    #logger.debug("いいね削除成功！")
    redirect_to  public_spot_path(spot)
  end

end

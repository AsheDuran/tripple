class Admin::SpotsController < ApplicationController

  def index
    @spots = Spot.all
  end

  def show
    @spot = Spot.find(params[:id])
    @end_user = @spot.end_user
  end

  def destroy
    @spot = Spot.find(params[:id])
    @spot.destroy
    redirect_to admin_spots_path
  end

  def search
    @spots = Spot.where(prefecture_id: params[:prefecture_id]).published.or (Spot.where(genre_id: params[:genre_id])).published.or (Spot.where(name: params[:name])).published
    render :index
  end


  private

  def spot_params
    params.require(:spot).permit(:name, :prefecture_id, :genre_id)
  end

end

class Admin::SpotsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @spots = Spot.page(params[:page])
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
    @spots = Spot.where(prefecture_id: params[:prefecture_id]).page(params[:page]).or
    (Spot.where(genre_id: params[:genre_id])).page(params[:page]).or
    (Spot.where(name: params[:name])).page(params[:page])
    render :index
  end


  private

  def spot_params
    params.require(:spot).permit(:name, :prefecture_id, :genre_id)
  end

end

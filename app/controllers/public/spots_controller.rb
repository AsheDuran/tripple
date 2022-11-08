class Public::SpotsController < ApplicationController

  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(spot_params)
    @spot.end_user_id = current_end_user.id
    @spot.save
    redirect_to  public_spot_path(@spot)
  end

  def show
    @spot = Spot.find(params[:id])
    @end_user = @spot.end_user
    #byebug
  end

  def index
    @spots = Spot.all
  end

  def edit
    @spot = Spot.find(params[:id])
  end

  def update
    @spot = Spot.find(params[:id])
    @spot.update(spot_params)
    redirect_to public_spot_path(@spot)
  end

  def  destroy
    @spot = Spot.find(params[:id])
    @spot.destroy
    redirect_to public_spots_path
  end







  private

  def spot_params
    params.require(:spot).permit(:name, :explanation, :prefecture_id, :address, :genre_id, :image, :end_user_id)
  end


end

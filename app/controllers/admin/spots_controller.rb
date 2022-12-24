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
    query = Spot.all
    query = query.where(prefecture_id: params[:prefecture_id]) if params[:prefecture_id].present?
    query = query.where(genre_id: params[:genre_id]) if params[:genre_id].present?
    query = query.where("name LIKE ?", "%#{params[:name]}%") if params[:name].present?
    @spots = query.page(params[:page])
    render :index
  end

  private

  def spot_params
    params.require(:spot).permit(:name, :prefecture_id, :genre_id)
  end

end

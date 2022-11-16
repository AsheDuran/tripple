class Public::SpotsController < ApplicationController

  def new
    @spot = Spot.new
    @spots = Spot.published#公開しているもののみ表示するするため、.allではなく.published
  end

  def create
    @spot = Spot.new(spot_params)
    @spot.end_user_id = current_end_user.id
    if  @spot.save
      redirect_to  public_spot_path(@spot)
    else
      render :new
    end
  end

  def show
    @spot = Spot.find(params[:id])
    @end_user = @spot.end_user
    #byebug
    @comment = Comment.new
  end

  def index
    @spots = Spot.published

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

  def search
    # @spots = Spot.where(prefecture_id: params[:prefecture_id], genre_id: params[:genre_id]).published "or"条件足してない記述
    @spots = Spot.where(prefecture_id: params[:prefecture_id]).published.or (Spot.where(genre_id: params[:genre_id])).published.or (Spot.where(name: params[:name])).published
    render :index
  end





  private

  def spot_params
    params.require(:spot).permit(:name, :explanation, :prefecture_id, :address, :genre_id, :image, :end_user_id, :is_published_flag, :star)
  end


end

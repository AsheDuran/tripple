class Public::SpotsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :correct_user, only:[:edit, :update]

  def new
    @spot = Spot.new
    @spots = Spot.published#公開しているもののみ表示するするため、.allではなく.published
  end

  def create
    @spot = Spot.new(spot_params)
    @spot.end_user_id = current_end_user.id
    if  @spot.save
      flash[:notice] = "投稿が完了しました!"
      redirect_to  public_spot_path(@spot)
    else  flash[:notice] = "投稿に失敗しました..."
      render :new
    end
  end

  def show
    @spot = Spot.find(params[:id])
    @end_user = @spot.end_user
    if !@spot.is_published_flag && end_user_current?(@end_user)
     redirect_to public_spots_path
    end
    @comment = Comment.new
  end

  def index
    @spots = Spot.published.page(params[:page])
  end

  def edit
    @spot = Spot.find(params[:id])
  end

  def update
    @spot = Spot.find(params[:id])
    if @spot.update(spot_params)
      flash[:notice] = "編集が完了しました!"
      redirect_to public_spot_path(@spot)
    else  flash[:notice] = "編集に失敗しました..."
      render :edit
    end
  end

  def  destroy
    @spot = Spot.find(params[:id])
    @spot.destroy
    redirect_to public_spots_path
  end

  def search
    @spots = Spot.where(prefecture_id: params[:prefecture_id]).
                  published.
                  page(params[:page]).
                  or (Spot.where(genre_id: params[:genre_id])).
                  published.page(params[:page]).
                  or (Spot.where(name: params[:name])).
                  published.page(params[:page])
    render :index
  end

  def correct_user
    @spot = Spot.find(params[:id])
    redirect_to public_spots_path unless @spot.end_user == current_end_user
  end


  private


  def end_user_current?(end_user)
    end_user != current_end_user
  end

  def spot_params
    params.require(:spot).permit(:name, :explanation, :prefecture_id, :address, :genre_id, :image, :end_user_id, :is_published_flag, :star)
  end


end

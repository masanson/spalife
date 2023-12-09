class Admin::GenresController < ApplicationController
  before_action :validate_admin, only: [:create, :update]
  
  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "ジャンルが作成されました。"
      redirect_to admin_genres_path
    else
      flash.now[:alert] = "ジャンル作成が失敗しました"
      @genres = Genre.order(created_at: :desc).page(params[:page]).per(5)
      render :index
    end
  end
  
  def index
    @genres = Genre.order(genre_id: :desc).page(params[:page]).per(5)
    @genre = Genre.new
  end

  def edit
    @genre = Genre.find(params[:id])
  end
  
  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "ジャンルを更新しました。"
      redirect_to admin_genres_path
    else
      flash.now[:alert] = "ジャンル更新が失敗しました"
      render :edit
    end
  end
  
  private
  
  def genre_params
    params.require(:genre).permit(:name)
  end
  
  def validate_admin
    if not admin_signed_in?
      redirect_to request.referer
    end
  end
end

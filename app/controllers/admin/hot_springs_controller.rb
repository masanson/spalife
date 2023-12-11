class Admin::HotSpringsController < ApplicationController
  before_action :validate_admin, only: [:create, :update, :destroy]
  
  def index
    @hot_springs = HotSpring.order(created_at: :desc).page(params[:page]).per(5)
    @hot_springs = @hot_springs.where('name LIKE ?', "%#{params[:search]}%") if params[:search].present?
    @hot_springs = @hot_springs.where(prefecture_id: params[:prefecture_id]) if params[:prefecture_id].present?
    @hot_spring = HotSpring.new
  end

  def create
    @hot_spring = HotSpring.new(hot_spring_params)
    if @hot_spring.save
      flash[:notice] = "新たな温泉が発見されました！"
      redirect_to admin_hot_spring_path(@hot_spring.id)
    else
      flash.now[:alert] = "新たな温泉が発見できませんでした・・・"
      @hot_springs = HotSpring.order(created_at: :desc).page(params[:page]).per(5)
      render :index
    end
  end

  def show
    @hot_spring = HotSpring.find(params[:id])
    @hot_posts = @hot_spring.hot_posts.page(params[:page]).per(4).order(created_at: :desc)
    search_address = (@hot_spring.address_full).gsub(/[\d-]+/, '')
    results = Geocoder.search(search_address)
    @latlng = results.first.coordinates
  end

  def edit
    @hot_spring = HotSpring.find(params[:id])
  end

  def update
    @hot_spring = HotSpring.find(params[:id])
    if @hot_spring.update(hot_spring_params)
      flash[:notice] = "温泉情報を更新しました。"
      redirect_to admin_hot_spring_path(@hot_spring.id)
    else
      flash.now[:alert] = "温泉情報を更新が失敗しました"
      render :edit
    end
  end

  def destroy
    @hot_spring = HotSpring.find(params[:id])
    if @hot_spring.destroy
      flash[:notice] = "温泉が閉鎖しました。"
      redirect_to admin_hot_springs_path
    else
      flash.now[:alert] = "削除が失敗しました。"
      render :show
    end
    
  end

  private
  
  def hot_spring_params
    params.require(:hot_spring).permit(:hot_spring_image, :name, :introduction, :postal_code, :address, :telephone_number, :access, :prefecture_id)
  end
  
  def validate_admin
    if not admin_signed_in?
      redirect_to request.referer
    end
  end
end

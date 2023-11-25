class Public::HotSpringsController < ApplicationController
  def index
    @hot_springs = HotSpring.order(created_at: :desc).page(params[:page]).per(8)
    @hot_springs = @hot_springs.where('name LIKE ?', "%#{params[:search]}%") if params[:search].present?
    @hot_springs = @hot_springs.where(prefecture_id: params[:prefecture_id]) if params[:prefecture_id].present?
    @hot_spring = HotSpring.new
  end

  def show
    @hot_spring = HotSpring.find(params[:id])
    @hot_posts = @hot_spring.hot_posts.page(params[:page]).per(4).order(created_at: :desc)
    search_address = (@hot_spring.address_full).gsub(/[\d-]+/, '')
    results = Geocoder.search(search_address)
    @latlng = results.first.coordinates
  end
  
  private
  
  def hot_spring_params
    params.require(:hot_spring).permit(:hot_spring_image, :name, :introduction, :postal_code, :address, :telephone_number, :access, :prefecture_id)
  end
  
end

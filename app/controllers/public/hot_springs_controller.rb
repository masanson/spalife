class Public::HotSpringsController < ApplicationController
  def index
    @hot_springs = HotSpring.all
  end

  def show
    @hot_spring = HotSpring.find(params[:id])
    search_address = (@hot_spring.address_full).gsub(/[\d-]+/, '')
    results = Geocoder.search(search_address)
    @latlng = results.first.coordinates
  end
  
  private
  
  def hot_spring_params
    params.require(:hot_spring).permit(:hot_spring_image, :name, :introduction, :postal_code, :address, :telephone_number, :access, :prefecture_id)
  end
  
end

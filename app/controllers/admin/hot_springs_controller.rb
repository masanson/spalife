class Admin::HotSpringsController < ApplicationController
  def index
    @hot_springs = HotSpring.order(created_at: :desc).page(params[:page]).per(8)
    @hot_springs = @hot_spring.where(genre_id: params[:prefecture_id]) if params[:prefecture_id].present?
    @hot_springs = @hot_spring.where('name LIKE ?', "%#{params[:search]}%") if params[:search].present?
    @hot_spring = HotSpring.new
  end

  def create
    @hot_spring = HotSpring.new(hot_spring_params)
    if @hot_spring.save
      redirect_to admin_hot_spring_path(@hot_spring.id)
    else
      render :index
    end
  end

  def show
    @hot_spring = HotSpring.find(params[:id])
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
      redirect_to admin_hot_spring_path(@hot_spring.id)
    else
      render :edit
    end
  end

  def destroy
    @hot_spring = HotSpring.find(params[:id])
    @hot_spring.destroy
    redirect_to admin_hot_springs_path
  end

  private
  
  def hot_spring_params
    params.require(:hot_spring).permit(:hot_spring_image, :name, :introduction, :postal_code, :address, :telephone_number, :access, :prefecture_id)
  end
end

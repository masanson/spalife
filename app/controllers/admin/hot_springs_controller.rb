class Admin::HotSpringsController < ApplicationController
  def index
    @hot_spring = HotSpring.new
  end

  def show
  end

  def edit
  end
  
  private
  
  def hot_spring_params
    params.require(:hot_spring).permit(:hot_spring_image, :name, :introduction, :postal_code, :address, :telephone_number, :access, :prefecture_id)
  end
end

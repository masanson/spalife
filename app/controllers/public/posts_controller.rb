class Public::PostsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def edit
  end
  
  private
  
  def post_params
    params.require(:po).permit(:user_image, :last_name, :first_name, :last_name_kana, :first_name_kana, :user_name, :sex, :email, :postal_code, :address, :telephone_number)
  end
end

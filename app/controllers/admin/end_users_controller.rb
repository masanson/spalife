class Admin::EndUsersController < ApplicationController
  def show
    @end_user = EndUser.find(params[:id])
    @posts = @end_user.posts
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end
  
  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      redirect_to admin_end_user_path(@end_user.id)
    else
      render :edit
    end
  end
  
  private
  
  def end_user_params
    params.require(:end_user).permit(:user_image, :last_name, :first_name, :last_name_kana, :first_name_kana, :user_name, :sex, :email, :postal_code, :address, :telephone_number, :is_active)
  end
end

class Public::EndUsersController < ApplicationController
  def show
    @end_user =EndUser.find(params[:id])
  end

  def edit
  end

  def withdrawal
  end
  
  private
  
  def end_user_params
    params.require(:end_user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :user_name, :sex, :email, :postal_code, :address, :telephone_number)
  end
end

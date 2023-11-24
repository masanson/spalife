class Admin::EndUsersController < ApplicationController
  def show
    @end_user =EndUser.find(params[:id])
    @hot_posts = @end_user.hot_posts
    @published_posts =@hot_posts.where(status: "published").order(created_at: :desc).page(params[:page]).per(5)
    @draft_posts = @hot_posts.where(status: "draft").order(created_at: :desc).page(params[:page]).per(5)
    @unpublished_posts = @hot_posts.where(status: "unpublished").order(created_at: :desc).page(params[:page]).per(5)
    favorites = Favorite.where(end_user_id: @end_user.id).pluck(:hot_post_id)
    @favorite_posts = HotPost.find(favorites)
    @favorite_posts = Kaminari.paginate_array(@favorite_posts).page(params[:page]).per(5)
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end
  
  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      flash[:notice] = "ユーザー情報が更新されました。"
      redirect_to admin_end_user_path(@end_user.id)
    else
      flash.now[:alert] = "ユーザー情報の更新が失敗しました。"
      render :edit
    end
  end
  
  private
  
  def end_user_params
    params.require(:end_user).permit(:user_image, :last_name, :first_name, :last_name_kana, :first_name_kana, :user_name, :sex, :email, :postal_code, :address, :telephone_number, :is_active, :introduction)
  end
end

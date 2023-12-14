class Public::FavoritesController < ApplicationController
  before_action :ensure_normal_user, only: [:create, :destroy]
  
  def create
    @post_favorite = Favorite.new(end_user_id: current_end_user.id, hot_post_id: params[:hot_post_id])
    @post_favorite.save
    hot_post = HotPost.find(params[:hot_post_id])
    hot_post.create_notification_favorite!(current_end_user)
    redirect_to public_hot_post_path(params[:hot_post_id])
  end

  def destroy
    @post_favorite = Favorite.find_by(end_user_id: current_end_user.id, hot_post_id: params[:hot_post_id])
    @post_favorite.destroy
    redirect_to public_hot_post_path(params[:hot_post_id])
  end
  
  private
  
  def ensure_normal_user
    if current_end_user.email == 'guest@example.com'
      flash[:notice] = "ゲストユーザーはいいね機能を制限されてます。"
      redirect_to request.referer
    end
  end
end

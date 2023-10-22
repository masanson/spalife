class Public::FavoritesController < ApplicationController
  def create
    @post_favorite = Favorite.new(end_user_id: current_end_user.id, hot_post_id: params[:hot_post_id])
    @post_favorite.save
    hot_post = HotPost.find(param[:hot_post_id])
    hot_post.create_notification_favorite!
    respond_to :js
    redirect_to public_hot_post_path(params[:hot_post_id])
  end
  
  def destroy
    @post_favorite = Favorite.find_by(end_user_id: current_end_user.id, hot_post_id: params[:hot_post_id])
    @post_favorite.destroy
    redirect_to public_hot_post_path(params[:hot_post_id])
  end
end

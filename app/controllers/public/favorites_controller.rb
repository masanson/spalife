class Public::FavoritesController < ApplicationController
  def create
    hot_post = HotPost.find(params[:hot_post_id])
  end
  
  def destroy
    
  end
end

class Admin::HotPostsController < ApplicationController
  def index
    @hot_posts = HotPost.all
  end

  def show
    @hot_post = HotPost.find(params[:id])
  end

  def edit
    @hot_post = HotPost.find(params[:id])
  end
  
  def update
    @hot_post = HotPost.find(params[:id])
    if @hot_post.update(hot_post_params)
      redirect_to public_hot_post_path(@hot_post.id)
    else
      render :edit
    end
  end
  
  def destroy
    @hot_post = HotPost.find(params[:id])
    @hot_post.destroy
    redirect_to public_hot_posts_path
  end
  
  private
  
  def hot_post_params
    params.require(:hot_post).permit(:hot_post_image, :title, :body, :end_user_id, :genre_id, :hot_spring_id)
  end
end

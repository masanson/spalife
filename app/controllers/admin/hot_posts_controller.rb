class Admin::HotPostsController < ApplicationController
  def index
    @hot_posts = HotPost.published.order(created_at: :desc).page(params[:page]).per(8)
    @hot_posts = @hot_posts.where(genre_id: params[:genre_id]) if params[:genre_id].present?
    @hot_posts = @hot_posts.where('title LIKE ?', "%#{params[:search]}%") if params[:search].present?
  end

  def show
    @hot_post = HotPost.find(params[:id])
    @hot_spring = @hot_post.hot_spring_id
    @end_user = @hot_post.end_user
    @comments =@hot_post.comments.page(params[:page]).per(4).order(created_at: :desc)
  end

  def edit
    @hot_post = HotPost.find(params[:id])
  end
  
  def update
    @hot_post = HotPost.find(params[:id])
    if @hot_post.update(hot_post_params)
      flash[:notice] = "管理者権限で投稿の更新されました"
      redirect_to admin_hot_post_path(@hot_post.id)
    else
      flash.now[:alert] = "投稿の更新が失敗しました。"
      render :edit
    end
  end
  
  def destroy
    @hot_post = HotPost.find(params[:id])
    @hot_post.destroy
    flash[:notice] = "管理者権限で投稿を削除しました。"
    redirect_to admin_hot_posts_path
  end
  
  private
  
  def hot_post_params
    params.require(:hot_post).permit(:hot_post_image, :title, :body, :end_user_id, :genre_id, :hot_spring_id)
  end
end

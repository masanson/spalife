class Public::CommentsController < ApplicationController
  before_action :validate_user, only: [:destroy]

  def create
    @comment = Comment.new(comment_params)
    @hot_post = @comment.hot_post
    if @comment.save
      flash[:notice] = "コメントが作成されました。"
      @hot_post.create_notification_comment!(current_end_user, @comment.id)
      redirect_to public_hot_post_path(@hot_post.id)
    else
      flash.now[:alert] = "コメント作成が失敗しました。"
      @hot_post = @comment.hot_post
      @end_user = @hot_post.end_user
      @hot_spring = @hot_post.hot_spring_id
      @comments =@hot_post.comments.page(params[:page]).per(4).order(created_at: :desc)
      render 'public/hot_posts/show'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:notice] = "コメントが削除されました。"
      redirect_to request.referer
    else
      flash.now[:alert] = "コメント作成が失敗しました。"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :end_user_id, :hot_post_id)
  end

  def validate_user
    comment = Comment.find(params[:id])
    if current_end_user.id != comment.end_user.id
      redirect_to request.referer
    end
  end
end

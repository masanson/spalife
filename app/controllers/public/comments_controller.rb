class Public::CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @hot_post = @comment.hot_post
    if @comment.save
      @hot_post.create_notification_comment!(current_end_user, @comment.id)
      respond_to :js
    end
    redirect_to public_hot_post_path(@hot_post.id)
  end
  
  def destroy
   @hot_post = HotPost.find_by(params[:hot_post_id])
   @comment = Comment.find_by(params[:id])
   @comment.destroy
   redirect_to public_hot_post_path(@hot_post.id)
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content, :end_user_id, :hot_post_id)
  end
end

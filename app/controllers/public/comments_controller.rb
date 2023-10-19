class Public::CommentsController < ApplicationController
  def create
    @hot_post = HotPost.find_by(params[:hot_post_id])
    @comment = Comment.new(comment_params)
    @comment.save
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

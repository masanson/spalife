class Admin::CommentsController < ApplicationController
  before_action :validate_admin, only: [:destroy]
  
  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:notice] = "管理者権限でコメントが削除されました。"
      redirect_to request.referer
    else
      flash.now[:alert] = "コメント削除が失敗しました。"
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content, :end_user_id, :hot_post_id)
  end
  
  def validate_admin
    @comment = Comment.find(params[:id])
    if not admin_signed_in?
      redirect_to request.referer
    end
  end
end

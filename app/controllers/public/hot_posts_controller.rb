class Public::HotPostsController < ApplicationController
  before_action :validate_user, only: [:destroy, :update]
  before_action :draft_unpublished_post_check, only: [:show]
  before_action :ensure_normal_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    @hot_posts = HotPost.published.order(created_at: :desc).page(params[:page]).per(8)
    @hot_posts = @hot_posts.where(genre_id: params[:genre_id]) if params[:genre_id].present?
    @hot_posts = @hot_posts.where('title LIKE ?', "%#{params[:search]}%") if params[:search].present?
  end

  def show
    @hot_post = HotPost.find(params[:id])
    @end_user = @hot_post.end_user
    @hot_spring = @hot_post.hot_spring_id
    @comments =@hot_post.comments.page(params[:page]).per(4).order(created_at: :desc)
    @comment =Comment.new
  end

  def new
    @hot_post = HotPost.new
  end

  def create
    @hot_post = HotPost.new(hot_post_params)
    @end_user = current_end_user
    @hot_post.end_user_id = current_end_user.id
    if @hot_post.save
      if @hot_post.status == "draft"
        flash[:notice] = "下書きが保存されました。"
        redirect_to end_user_path(@end_user.id)
      elsif @hot_post.status == "unpublished"
        flash[:notice] = "非公開の投稿を作成しました。"
        redirect_to end_user_path(@end_user.id)
      else
        flash[:notice] = "投稿が成功しました！"
        redirect_to hot_post_path(@hot_post.id)
      end
    else
      flash.now[:alert] = "投稿・保存が失敗しました。"
      render :new
    end
  end

  def edit
    @hot_post = HotPost.find(params[:id])
    unless @hot_post.end_user.id == current_end_user.id
      flash[:notice] = "他の会員の投稿は編集出来ません"
      redirect_to root_path
    end
  end

  def update
    @end_user = current_end_user
    @hot_post = HotPost.find(params[:id])
    if @hot_post.update(hot_post_params)
      if @hot_post.status =="draft"
        notice_message = "下書きが保存されました。"
        redirect_path = end_user_path(@end_user.id)
      elsif @hot_post.status == "unpublished"
        notice_message = "投稿を非公開にしました。"
        redirect_path = end_user_path(@end_user.id)
      else
        notice_message = "投稿が公開されました！"
        redirect_path = hot_post_path(@hot_post.id)
      end
      flash[:notice] = notice_message
      redirect_to redirect_path
    else
      flash.now[:alert] = "投稿の更新が失敗しました。"
      render :edit
    end
  end

  def destroy
    @hot_post = HotPost.find(params[:id])
    if @hot_post.destroy
      flash[:notice] = "投稿を削除しました。"
      @end_user = @hot_post.end_user
      redirect_to end_user_path(@end_user.id)
    end
  end

  private

  def hot_post_params
    params.require(:hot_post).permit(:hot_post_image, :title, :body, :status, :end_user_id, :genre_id, :hot_spring_id)
  end

  def validate_user
    @hot_post = HotPost.find(params[:id])
    if current_end_user.id != @hot_post.end_user.id
      redirect_to request.referer
    end
  end

  def ensure_normal_user
    if current_end_user.email == 'guest@example.com'
      flash[:notice] = "ゲストユーザーは閲覧以外の投稿機能を制限されてます。"
      redirect_to request.referer
    end
  end

  def draft_unpublished_post_check
    @hot_post = HotPost.find(params[:id])
    if @hot_post.status != "published" && @hot_post.end_user.id != current_end_user.id
      flash[:notice] = "他の会員の下書き/非公開の投稿は編集出来ません"
      redirect_to root_path
    end
  end

end

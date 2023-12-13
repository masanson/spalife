class Public::NotificationsController < ApplicationController
  before_action :ensure_normal_user, only: [:index]
  def index
    @notifications = current_end_user.passive_notifications.order(created_at: :desc).page(params[:page]).per(5)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end
  
  def ensure_normal_user
    if current_end_user.email == 'guest@example.com'
      flash[:notice] = "ゲストユーザーは通知一覧を制限されてます。"
      redirect_to root_path
    end
  end
end

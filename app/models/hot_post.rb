class HotPost < ApplicationRecord
  belongs_to :genre
  belongs_to :end_user
  has_many :notifications, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: { message: "が無記入です。" }
  validates :body, presence: { message: "が無記入です。" }
  validates :status, presence: { message: "投稿状態が設定されておりません。" }

  enum status: { published: 0, draft: 1, unpublished: 2 }

  has_one_attached :hot_post_image

  def create_notification_favorite!(current_end_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and hot_post_id = ? and action = ?", current_end_user.id, end_user_id, id, 'favorite'])
    if temp.blank?
      notification = current_end_user.active_notifications.new(
        hot_post_id: id,
        visited_id: end_user_id,
        action: 'favorite'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_end_user, comment_id)
    temp_ids = Comment.select(:end_user_id).where(hot_post_id: id).where.not(end_user_id: current_end_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_end_user, comment_id, temp_id['end_user_id'])
    end
    save_notification_comment!(current_end_user, comment_id, end_user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_end_user, comment_id, visited_id)
    notification = current_end_user.active_notifications.new(
      hot_post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  def favorited?(end_user)
    favorites.where(end_user_id: end_user.id).exists?
  end

  def get_hot_post_image(width, height)
    hot_post_image.variant(resize_to_limit: [width, height]).processed
  end
end

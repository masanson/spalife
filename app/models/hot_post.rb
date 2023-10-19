class HotPost < ApplicationRecord
  belongs_to :genre
  belongs_to :end_user
  has_many :notifications, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :hot_post_image
  
  def favorited?(end_user)
    favorites.where(end_user_id: end_user.id).exists?
  end
  
  def get_hot_post_image(width, height)
    hot_post_image.variant(resize_to_limit: [width, height]).processed
  end
end
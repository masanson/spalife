class Post < ApplicationRecord
  belongs_to :genre
  belongs_to :end_user
  has_many :notifications, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_one_attached :post_image

  def favorited_by?(end_user)
    favorite.exist?(end_user_id: end_user.id)
  end

  def get_post_image(width, height)
    post_image.variant(resize_to_limit: [width, height]).processed
  end
end

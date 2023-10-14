class Post < ApplicationRecord
  belongs_to :
  has_many :notifications, dependent: :destroy
  
  has_one_attached :post_image
  
  def get_post_image(width, height)
    post_image.variant(resize_to_limit: [width, height]).processed
  end
end

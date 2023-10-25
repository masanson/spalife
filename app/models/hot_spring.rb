class HotSpring < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  
  has_one_attached :hot_spring_image
  
  def get_hot_spring_image(width, height)
    hot_spring_image.variant(resize_to_limit: [width, height]).processed
  end
end

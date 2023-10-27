class HotSpring < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  
  has_one_attached :hot_spring_image
  
  def address_full
    '@hot_spring.find_by(Prefecture.name: :prefecture_id)'+' '+ address
  end
  
  def get_hot_spring_image(width, height)
    hot_spring_image.variant(resize_to_limit: [width, height]).processed
  end
end

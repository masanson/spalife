class HotSpring < ApplicationRecord
  
  has_one_attached :hot_spring_image
  
  def get_post_image(width, height)
    post_image.variant(resize_to_limit: [width, height]).processed
  end
end

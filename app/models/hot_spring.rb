class HotSpring < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  has_many :hot_posts, dependent: :destroy

  validates :name, presence: { message: "が無記入です。" }
  validates :introduction, presence: { message: "が無記入です。" }
  validates :postal_code, presence: { message: "が無記入です。" }
  validates :address, presence: { message: "が無記入です。" }
  validates :telephone_number, presence: { message: "が無記入です。" }
  validates :access, presence: { message: "が無記入です。" }

  has_one_attached :hot_spring_image

  def address_full
    prefecture.name + address
  end

  def get_hot_spring_image(width, height)
    hot_spring_image.variant(resize_to_limit: [width, height]).processed
  end
end

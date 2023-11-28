class Genre < ApplicationRecord
  has_many :hot_posts, dependent: :destroy
  validates :name, presence: { message: "が無記入です。" }
end

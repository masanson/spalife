class Comment < ApplicationRecord
  has_many :notifications, dependent: :destroy
  belongs_to :end_user
  belongs_to :hot_post
  
  validates :content, presence: { message: "が無記入です。" }
end

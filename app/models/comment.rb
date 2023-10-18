class Comment < ApplicationRecord
  has_many :notifications, dependent: :destroy
  belongs_to :end_user
  belongs_to :hot_post
  
end

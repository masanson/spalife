class Comment < ApplicationRecord
  has_many :notifications, dependent: :destroy
end

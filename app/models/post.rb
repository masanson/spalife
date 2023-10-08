class Post < ApplicationRecord
  has_many :notifications, dependent: :destroy
end

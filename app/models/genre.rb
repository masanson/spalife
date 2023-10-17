class Genre < ApplicationRecord
  has_many :hot_posts, dependent: :destroy
end

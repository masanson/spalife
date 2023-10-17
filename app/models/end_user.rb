class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  has_many :hot_posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  enum sex: { male: 0, female: 1, not_applicable: 2 }
  
  has_one_attached :user_image
  
  def name
    last_name + ' ' + first_name
  end
  
  def name_kana
    last_name_kana + ' ' + firstt_name_kana
  end
  
  def is_active_status
    if is_active == true
      "有効"
    else
      "退会"
    end
  end
  
  def get_user_image(width, height)
    unless user_image.attached?
      file_path = Rails.root.join('app/assets/images/user_default_image.jpg')
      user_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    user_image.variant(resize_to_limit: [width, height]).processed
  end
end

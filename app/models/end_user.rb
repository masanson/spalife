class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  has_many :hot_posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :genres, through: :hot_posts

  enum sex: { male: 0, female: 1, not_applicable: 2 }

  validates :email, presence: { message: "が無記入です。" }, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, }
  validates :last_name, presence: { message: "が無記入です。" }, length: { maximum: 5 }
  validates :first_name, presence: { message: "が無記入です。" }, length: { maximum: 5 }
  validates :last_name_kana, presence: { message: "が無記入です。" }, length: { maximum: 10 }
  validates :first_name_kana, presence: { message: "が無記入です。" }, length: { maximum: 10 }
  validates :user_name, presence: { message: "が無記入です。" }, length: { maximum: 10 }
  validates :sex, presence: { message: "が設定されてません。" }
  validates :postal_code, presence: { message: "が無記入です。" }
  validates :address, presence: { message: "が無記入です。" }
  validates :telephone_number, presence: { message: "が無記入です。" }

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

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |end_user|
      end_user.password = ENV['GUEST_KEY']
      end_user.last_name = "山田"
      end_user.first_name = "太郎"
      end_user.last_name_kana = "ヤマダ"
      end_user.first_name_kana = "タロウ"
      end_user.user_name = "ゲスト"
      end_user.sex = 2
      end_user.postal_code = "1234567"
      end_user.address = "東京都八王子市泉町"
      end_user.telephone_number = "123456789"
      end_user.is_active = true
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

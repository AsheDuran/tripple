class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


    has_many :spots, dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_many :comments, dependent: :destroy
    # has_many :favorited_spots, through: :favorites, source: :spot#いいね数ランキングで記述
    has_one_attached :profile_image

    validates :first_name, presence: true
    validates :last_name, presence: true

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_profile_image.png')
      profile_image.attach(io: File.open(file_path), filename: 'no_profile_image.png', content_type: 'image/png')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def name
    # self.first_name + ' ' + self.last_name と同義で#{}はRubyの式展開
    "#{self.last_name} #{self.first_name}"
  end

  def self.guest
    find_or_create_by!(email: 'test@com') do |end_user|#find_or_create_by!でゲストユーザーが無ければ作成、あれば取り出す
      end_user.password = SecureRandom.urlsafe_base64#↓ゲストユーザーがない時に作成するユーザー情報
      end_user.name = 'サンプル 太郎'
    end
  end

end

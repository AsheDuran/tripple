class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments, dependent: :destroy

  def self.guest
    find_or_create_by!(email: 'admin.test@com') do |admin|#find_or_create_by!でゲストユーザーが無ければ作成、あれば取り出す
      admin.password = SecureRandom.urlsafe_base64#↓ゲストユーザーがない時に作成するユーザー情報
    end
  end


end

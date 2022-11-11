class Spot < ApplicationRecord

  belongs_to :prefecture
  belongs_to :genre
  belongs_to :end_user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :image

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      image.attach(io: File.open(file_path), filename: 'no_image.png', content_type: 'image/png')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(end_user)#favorited_by?メソッドでいいねを既に押しているか、押していないか判断
    favorites.exists?(end_user_id: end_user.id)
  end
end

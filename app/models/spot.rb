class Spot < ApplicationRecord

  belongs_to :prefecture
  belongs_to :genre
  belongs_to :end_user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  # has_many :favorited_end_users, through: :favorites, source: :end_user#いいね数ランキングで記述

  has_one_attached :image

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      image.attach(io: File.open(file_path), filename: 'no_image.png', content_type: 'image/png')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  scope :published, -> {where(is_published_flag: true)}# 公開・非公開機能
  scope :unpublished, -> {where(is_published_flag: false)}

  def favorited_by?(end_user)#favorited_by?メソッドでいいねを既に押しているか、押していないか判断
    favorites.exists?(end_user_id: end_user.id)
  end
end

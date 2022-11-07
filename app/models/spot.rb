class Spot < ApplicationRecord

  belongs_to :prefecture
  belongs_to :genre
  belongs_to :end_user


  has_one_attached :image

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      image.attach(io: File.open(file_path), filename: 'no_image.png', content_type: 'image/png')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end


end

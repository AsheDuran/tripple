class Genre < ApplicationRecord

  has_many :spots, dependent: :destroy

end

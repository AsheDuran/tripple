class Prefecture < ApplicationRecord

  has_many :spots, dependent: :destroy

end

class Prefecture < ApplicationRecord

  has_many :spots, dependent: :destroy

  def self.looks(search, word)
    if search == "partial_match"
      @prefecture = Prefecture.where("name LIKE?","%#{word}%")
    else
      @prefecture = Prefecture.all
    end
  end

end

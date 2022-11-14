class Genre < ApplicationRecord

  has_many :spots, dependent: :destroy

  def self.looks(search, word)
    if search == "partial_match"
      @genre = Genre.where("name LIKE?","%#{word}%")
    else
      @genre = Genre.all
    end
  end

end

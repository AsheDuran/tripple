class HomesController < ApplicationController

  def top
    spot_ranking_ids = Favorite.select('spot_id, count(id) as count').group('spot_id').order('count
 DESC').limit(5).map {|favorite| favorite.spot_id}
    # =>  [ 7, 6, 3, 5, 10]
    @spots = Spot.find(spot_ranking_ids)
  end

  def derivation
  end

  def outline
  end

end

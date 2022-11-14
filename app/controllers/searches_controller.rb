class SearchesController < ApplicationController

  def search
    @prefecture = params[:prefecture]
    @genre = params[:genre]
  end

end

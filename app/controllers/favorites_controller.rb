class FavoritesController < ApplicationController
  before_filter :check_login
  
  def create
    @favorite = Favorite.new(listing_id: params[:listing_id])
    current_user.favorites << @favorite
    respond_to do |format|
      format.html { redirect_to listings_url }
      format.json { render json: nil, status: 200 }
    end
  end
  
  def destroy
    @favorite = current_user.favorites.where(listing_id: params[:listing_id])
    respond_to do |format|
      format.html { redirect_to listings_url }
      format.json { render json: nil, status: 200 }
    end
  end
end

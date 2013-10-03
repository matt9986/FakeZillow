class FavoritesController < ApplicationController
  before_filter :check_login
  
  def create
    @listing = Listing.find(params[:listing_id])
    current_user.favorite_listings << @listing
    respond_to do |format|
      format.html { redirect_to listing_url(@listing)}
      format.json { render json: nil, status: 200 }
    end
  end
  
  def destroy
    @listing = Listing.find(params[:listing_id])
    @favorite = current_user.favorites.where(listing_id: @listing.id).first
    @favorite.destroy
    respond_to do |format|
      format.html { redirect_to listings_url }
      format.json { render json: nil, status: 200 }
    end
  end
end

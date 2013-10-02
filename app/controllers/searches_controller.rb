class SearchesController < ApplicationController
  def new
    render :new
  end
  
  def index
    @listings = Listing.search_params(params[:listing]).page(params[:page])
    respond_to do |format|
      format.html render :show
      format.json render json: @listings
    end
  end
end

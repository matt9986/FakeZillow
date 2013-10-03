class SearchesController < ApplicationController
  def new
    render :new
  end
  
  def index
    lat, lng = params[:listing][:coord].split(", ")
    @listings = Listing.find_near_coord(lat.to_f, lng.to_f).page(params[:page])
    @listings = @listings.where(price: 0 .. params[:listing][:max_price].to_i) unless params[:listing][:max_price].empty?
    
    @json = @listings.to_gmaps4rails do |listing, marker|
      marker.infowindow render_to_string(:partial => "/listings/map_window", :locals => { :listing => listing})
      marker.title listing.price.to_s
    end
    
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @listings }
    end
  end
end

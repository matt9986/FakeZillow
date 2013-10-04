class ListingsController < ApplicationController
  before_filter :check_login, except: [:show]
  before_filter :check_auth, only: [:destroy, :edit, :update]
  
  def create
    params[:listing][:user_id] = current_user.id
    @listing = Listing.new(params[:listing])
    if @listing.save
      respond_to do |format|
        format.html { redirect_to listing_url(@listing) }
        format.json { render json: @listing }
      end
    else
      flash[:errors] = @user.errors.full_messages
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @listing.errors.full_messages, status: 422 }
      end
    end
  end
  
  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url }
      format.json { render json: nil, status: 200 }
    end
  end
  
  def edit
    @listing ||= Listing.find(param[:id])
    render :edit
  end
  
  def index
    if current_user.agent
      @listings = current_user.listings.reverse_order.page(params[:page])
    else
      @listings = current_user.favorite_listings.reverse_order.page(params[:page])
    end
    
    @json = @listings.to_gmaps4rails do |listing, marker|
      marker.infowindow render_to_string(:partial => "/listings/map_window", :locals => { :listing => listing})
      marker.title listing.price.to_s
    end
    
    respond_to do |format|
      format.html { render :index }
      format.json { rendre json: @listings }
    end
  end
  
  def new
    @listing = Listing.new
    render :new
  end
  
  def show
    @listing = Listing.find(params[:id])
    respond_to do |format|
      format.html { render :show }
      format.json { rendre json: @listing }
    end
  end
  
  def update
    params[:listing][:user_id] = current_user.id
    @listing ||= Listing.find(params[:id])
    if @listing.update_attributes(params[:listing])
      respond_to do |format|
        format.html { redirect_to listing_url(@listing) }
        format.json { render json: @listing }
      end
    else
      flash[:errors] = @listing.errors.full_messages
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: @listing.errors.full_messages, status: 422 }
      end
    end
  end
  
  def check_auth
    @listing = Listing.find(params[:id])
    unless current_user.id == @listing.user_id
      respond_to do |format|
        format.html { redirect_to listing_url(@listing) }
        format.json { render json: "Not authorized", status: 403 }
      end
    end
  end
end

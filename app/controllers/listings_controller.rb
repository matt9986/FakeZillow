class ListingsController < ApplicationController
  before_filter :check_login, only: [:new, :create, :index]
  before_filter :check_auth, only: [:edit, :update]
  
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
  
  def edit
    @listing ||= Listing.find(param[:id])
    render :edit
  end
  
  def index
    @listings = current_user.listings.page(params[:page])
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
      redirect_to listing_url(@listing)
    end
  end
end

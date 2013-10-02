class Listing < ActiveRecord::Base
  extend FriendlyId
  acts_as_gmappable
  attr_accessible :address, :city, :price, :state, :user_id, :zip
  validates :address, :city, :price, :state, :user_id, :zip, presence: true
  friendly_id :address_then_city, use: :slugged
  
  belongs_to :user
  
  def self.search_params(search)
    listings = Listing.where(zip: 
      
      ssearch[:search])
    #price, city/state, zip
  end
  
  private
  def address_then_city
    "#{self.address}, #{self.city}"
  end
  
  def gmaps4rails_address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.address}, #{self.city}, #{self.state} #{self.zip}" 
  end
end

class Listing < ActiveRecord::Base
  extend FriendlyId
  attr_accessible :address, :city, :price, :state, :user_id, :zip
  validates :address, :city, :price, :state, :user_id, :zip, presence: true
  friendly_id [:address, :city], use: :slugged
  
  belongs_to :user
  
  def self.search(search)
    listings = Listing.where(zip: search[:search])
    #price, city/state, zip
  end
end

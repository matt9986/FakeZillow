class Listing < ActiveRecord::Base
  extend FriendlyId
  acts_as_gmappable
  attr_accessible :address, :city, :price, :state, :user_id, :zip
  validates :address, :city, :price, :state, :user_id, :zip, presence: true
  friendly_id :address_then_city, use: :slugged
  
  belongs_to :user
  has_many :favorites
  
  def self.find_near_coord(lat, lng, dist = 40.2) # 25 mile "radius"
    lat, lng = self.deg_to_rad( lat ), self.deg_to_rad( lng )
    r = dist / 6371.0 #Dist is in km

    lat_min, lat_max = self.rad_to_deg(lat - r), self.rad_to_deg(lat + r)

    dlon = Math.asin(Math.sin(r) / Math.cos(lat))
    lng_min, lng_max = self.rad_to_deg(lng - dlon), self.rad_to_deg(lng + dlon)

    self.where(latitude: lat_min .. lat_max, longitude: lng_min .. lng_max)
  end
  
  private
  def address_then_city
    "#{self.address}, #{self.city}"
  end
  
  def gmaps4rails_address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.address}, #{self.city}, #{self.state} #{self.zip}" 
  end
  
  def self.deg_to_rad(deg)
    (deg / 180.0) * Math::PI
  end

  def self.rad_to_deg(rad)
    (rad * 180.0) / Math::PI
  end

end

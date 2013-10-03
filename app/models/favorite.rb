class Favorite < ActiveRecord::Base
  attr_accessible :listing_id, :user_id
  
  belongs_to :user
  belongs_to :listing
end

class User < ActiveRecord::Base
  attr_accessible :agent, :email, :pass_hash
  validates :email, presence: true, unquiness: true
  
  has_many :listings
end

require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :agent, :email, :password
  validates :email, presence: true, uniqueness: true
  validates :pass_hash, presence: true
  validates_format_of :email, 
  										:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,4})\Z/i, 
  										:on => :create
  
  has_many :listings, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_listings, through: :favorites, source: :listing
  
  def password
  	@password || BCrypt::Password.new(self.pass_hash)
  end

	def password=(password)
		@password = password
		self.pass_hash = BCrypt::Password.create(password)
	end

	def reset_session
		token = SecureRandom.urlsafe_base64

		until User.find_by_session_token(token).nil?
			token = SecureRandom.urlsafe_base64
		end

		self.session_token = token
		token
	end
end

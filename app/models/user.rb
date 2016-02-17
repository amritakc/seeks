class User < ActiveRecord::Base
	has_many :secrets, dependent: :destroy
	has_many :likes, dependent: :destroy
	has_many :secrets_liked, through: :likes, source: :secret

	has_secure_password
	validates_confirmation_of :password
	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
	validates :name, presence: true
	validates :email,  uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
	validates :password, length: {minimum: 6}, allow_nil: true, confirmation: true
	# validates :password_confirmation, presence: true

end

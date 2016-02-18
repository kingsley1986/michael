class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	validates :password, presence: true
	validates :password_confirmation, presence: true

	validates :name, presence: true, length: {maximum: 50}

	validates :email, presence: true, length: {maximum: 250}
	validates :password, length: { minimum: 6}

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 250},
						format: { with: VALID_EMAIL_REGEX },
						uniqueness: { case_sensitive: false }
	has_secure_password

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
															BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end
end

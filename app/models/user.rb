class User < ApplicationRecord
	has_secure_password 
	validates :email, format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i}
	validates :email, uniqueness: true 
	validates :name, presence: true, uniqueness: true
end

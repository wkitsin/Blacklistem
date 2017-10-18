class User < ApplicationRecord
	has_secure_password
	validates :name, presence: true
	validates :email, presence: true, uniqueness: true,  format: {with: /@\w{2,}\./,
        message: "wrong format"}
	has_many :restaurants
	def self.from_omniauth(auth)
	    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
	      user.provider = auth.provider
	      user.email = auth.info.email
	      user.password = SecureRandom.hex(5)
	      user.uid = auth.uid
	      user.name = auth.info.name
	      user.oauth_token = auth.credentials.token
	      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
	      user.save!
	    end
	  end
end

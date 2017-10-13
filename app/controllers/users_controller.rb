class UsersController < ApplicationController

	before_action :require_login, except: [:new]
	def index 
	end 

	def new 
		@user = User.new 
	end 

	def create 
		user = User.new(user_params)
		if user.save 
			redirect_to root_path  
		else 
			flash[:error] = 'failed to create user'
			redirect_to  new_user_path 
		end 
	end 

	def require_login 
		if current_user == nil 
			redirect_to sessions_home_path 
		end 
	end 

	private 

	def user_params 
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end 
end

class UsersController < ApplicationController

	def show 
		list
	end 

	def new 
		@user = User.new 
	end 

	def create 
		@user = User.new(user_params)
		if @user.save 
			flash[:success] = 'User created'
			session[:user_id] = @user.id
			redirect_to root_path 
		else 
			flash[:error] = 'User fail to create'
			redirect_to root_path 
		end 
	end 

	private 
	def user_params
		params.require(:user).permit(:email, :name, :password)
	end 
end

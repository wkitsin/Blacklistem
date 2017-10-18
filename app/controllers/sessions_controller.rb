class SessionsController < ApplicationController

	
	def create 
		# byebug 
		login = User.find_by(email: params[:user][:email]).try(:authenticate, params[:user][:password]) 
		if login == nil 
			flash[:error] = 'bad email or password'
			redirect_to login_path 
		else 
			session[:user_id] = login.id 
			flash[:sucess] = 'login successful'
			redirect_to root_path 
		end 
	end 

	def create_omniauth
		user = User.from_omniauth(request.env["omniauth.auth"])
	    session[:user_id] = user.id
	    redirect_to root_path
	end 


	def login 
		@user = User.new 
	end 

	def destroy 
		session[:user_id] = nil 
		redirect_to home_index_path
	end 
end

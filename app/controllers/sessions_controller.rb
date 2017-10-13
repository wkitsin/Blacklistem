class SessionsController < ApplicationController

	def login
	end 

	def home 
	end 
	
	def create 
		# byebug 
		login = User.find_by(email: params[:session][:email]).try(:authenticate, params[:session][:password]) 
		if login == nil 
			flash[:error] = 'bad email or password'
			redirect_to login_path 
		else 
			session[:user_id] = login.id 
			flash[:sucess] = 'login successful'
			redirect_to users_path 
		end 
	end 

	def destroy 
		session[:user_id] = nil 
		redirect_to login_path
	end 
end

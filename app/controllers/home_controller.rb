class HomeController < ApplicationController

	before_action :require_login, except: [:index, :create]

	def show 
		@restaurant = Restaurant.new 
		@res = Restaurant.all
		@hash = Restaurant.maps(@res)
		# byebug 
		all 
	end 

	def one 
		# byebug 
		@res = Restaurant.find(params[:id])
		@hash = Restaurant.maps(@res)
	end 

	def search 
		@search = search_params.values 
		hash = Hash[search_params.keys.zip(@search)]
		@restaurant = Restaurant 

		hash.each do |key, value|
			@res = @restaurant.send(key,value)
		end 
		@hash = Restaurant.maps(@res)
	end 

	def create 
		@restaurant = current_user.restaurants.new(res_params)

		if @restaurant.save 
			flash[:success] = 'Please double check the listing'
			redirect_to edit_home_path(@restaurant.id)
		else 
			flash[:success] = 'Oops there was an error. Please try again'
			redirect_to root_path
		end 
	end 

	def edit 
		@res = Restaurant.last 
		@name = @restaurant.adress 
		@hash = Restaurant.maps(@res)
		 
	end 

	def update
		@restaurant = Restaurant.find(params[:id]).update(update_res_params)
		flash[:success] = 'Feedback has been saved'
		redirect_to root_path
	end 


	def index 
	end 

	def destroy 
		restaurant = Restaurant.find(params[:id]).delete
		
		list
		respond_to do |format|
	        format.js {flash[:notice] = 'The location has been deleted'}
	    end
	end 

	def require_login 
		if current_user == nil 
			redirect_to home_index_path 
		end 
	end 

	private 
	def res_params 
		params.require(:restaurant).permit(:adress, :description)
	end 

	def search_params 
		params.require(:search).permit(:adress)
	end 

	def update_res_params 
		params.require(:restaurant).permit(:description, :latitude, :longitude)
	end 
end

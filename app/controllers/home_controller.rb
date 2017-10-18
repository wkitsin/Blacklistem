class HomeController < ApplicationController

	before_action :require_login, except: [:index, :create]

	def show 
		@restaurant = Restaurant.new 
		@res = Restaurant.all
		@hash = Gmaps4rails.build_markers(@res) do |restaurant, marker|
		  marker.lat restaurant.latitude
		  marker.lng restaurant.longitude
		  marker.infowindow restaurant.adress

		end

	end 

	def search 
		@search = search_params.values 
		hash = Hash[search_params.keys.zip(@search)]
		@restaurant = Restaurant 

		hash.each do |key, value|
			@restaurant = @restaurant.send(key,value)
		end 
		@hash = Gmaps4rails.build_markers(@restaurant) do |restaurant, marker|
		  marker.lat restaurant.latitude
		  marker.lng restaurant.longitude
		  marker.infowindow restaurant.adress

		end 
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
		@restaurant = Restaurant.last 
		@hash = Gmaps4rails.build_markers(@restaurant) do |restaurant, marker|
		  marker.lat restaurant.latitude
		  marker.lng restaurant.longitude
		  marker.infowindow restaurant.adress

		end 
		 
	end 

	def update
		if params[:commit] == "Confirm"
			@restaurant = Restaurant.find(params[:id]).update(res_params)
			flash[:success] = 'Feedback has been saved'
			redirect_to root_path
		else 
			@restaurant = Restaurant.find(params[:id]).update(res_params)
			redirect_to edit_home_path(params[:id])
		end 
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
end

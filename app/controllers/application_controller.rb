class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def list 
  	@name = current_user.name 
  	restaurant = current_user.restaurants
  	location = [] 
  	description = [] 
  	id = [] 
  	restaurant.each do |i|
  		location << i.adress
  		description << i.description
  		id << i.id
  	end 
  	@merge = location.zip(description, id)
  	# byebug 
  end 

  def all 
    restaurant = Restaurant.all 
    location = [] 
    description = [] 
    id = [] 
    restaurant.each do |i|
      location << i.adress
      description << i.description
      id << i.id
    end 
    @merge = location.zip(description, id)
  end 

  def authorization
    if current_user.id != Restaurant.find(params[:id]).user.id
      flash[:error] = 'No authroity to perform the action'
      redirect_to root_path 
    end 
  end 
end

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
end

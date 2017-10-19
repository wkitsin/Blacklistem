class Restaurant < ApplicationRecord
    belongs_to :user
	geocoded_by :adress
	validates :adress, presence: true 
    before_create :geocode 
    scope :adress, -> (adress) {

    	if adress.blank?
    		all
    	else 
    		# byebug 
            relation = Restaurant.where(id: 0)
            adress.split.each do |j|
    		  relation = relation.or(Restaurant.where("adress ilike ? ", "%#{j}%"))
            end 
            relation
    	end 

    }

    def self.maps(res)
        @hash = Gmaps4rails.build_markers(res) do |restaurant, marker|
          marker.lat restaurant.latitude
          marker.lng restaurant.longitude
          marker.infowindow restaurant.adress

        end
        
    end 

end

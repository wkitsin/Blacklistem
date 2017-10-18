class Restaurant < ActiveRecord::Migration[5.1]
  def change
  	create_table :restaurants do |t|
  	  t.float :latitude
      t.float :longitude
      t.string :name
      t.string :adress
      t.string :description
  	end
  end
end

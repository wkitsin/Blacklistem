class Remove < ActiveRecord::Migration[5.1]
  def change
  	remove_column :restaurants, :name 
  end
end

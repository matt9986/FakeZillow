class AddLatitudeAndLongitudeColumnsToListings < ActiveRecord::Migration
  def change
    add_column :listings, :latitude,  :float #you can change the name, see wiki
    add_column :listings, :longitude, :float #you can change the name, see wiki
    add_column :listings, :gmaps, :boolean, default: false #not mandatory, see wiki
    add_index :listings, :latitude
    add_index :listings, :longitude
  end
end

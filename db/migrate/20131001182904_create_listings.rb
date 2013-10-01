class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.integer :price
      t.integer :user_id
      t.string :slug

      t.timestamps
    end
    
    add_index :listings, :price
    add_index :listings, [:city, :state]
    add_index :listings, :zip
    add_index :listings, :user_id
    add_index :listings, :slug, unique: true
  end
end

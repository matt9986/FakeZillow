class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.string :listing_id
      t.string :user_id

      t.timestamps
    end
    add_index :favorites, :listing_id
    add_index :favorites, :user_id
  end
end

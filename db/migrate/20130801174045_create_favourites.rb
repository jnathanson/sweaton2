class CreateFavourites < ActiveRecord::Migration
  def change
    create_table :favourites do |t|
      t.integer :user_id
      t.integer :venue_id

      t.timestamps
    end
    add_index :favourites, :user_id
    add_index :favourites, :venue_id
    add_index :favourites, [:user_id, :venue_id], unique: true
  end
end

class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.integer :venue_id

      t.timestamps
    end
    add_index :events, :venue_id
  end
end

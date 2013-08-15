class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :event_id
      t.integer :venue_id
      t.string :content
      t.integer :stars

      t.timestamps
    end
  end
end

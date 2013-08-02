class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :tag_id
      t.integer :event_id

      t.timestamps
    end
    add_index :relationships, :tag_id
    add_index :relationships, :event_id
    add_index :relationships, [:tag_id, :event_id], unique: true
  end
end

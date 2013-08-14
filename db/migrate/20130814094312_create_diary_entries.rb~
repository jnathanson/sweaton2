class CreateDiaryEntries < ActiveRecord::Migration
  def change
    create_table :diary_entries do |t|
      t.integer :user_id
      t.datetime :start_time
      t.boolean :repeating
      t.integer :event_id, default: 0
      t.string :name

      t.timestamps
    end
  end
end

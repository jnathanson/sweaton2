class AddTimingsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :start_time, :datetime
    add_column :events, :end_time,   :datetime
    add_index :events, :start_time
  end
end

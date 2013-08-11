class AddDayOfWeekToEvents < ActiveRecord::Migration
  def change
    add_column :events, :day, :integer # 0=Monday, 6=Sunday
    add_column :events, :cost, :string
    add_column :events, :contact, :string
    add_column :events, :website, :string
    add_column :events, :gender, :string
  end
end

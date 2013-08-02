class AddUserTypes < ActiveRecord::Migration
  def change
    add_column :users, :mentor, :boolean, default: false
    add_column :users, :organiser, :boolean, default: false
  end
end

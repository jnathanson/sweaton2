class RemoteAttendings < ActiveRecord::Migration
  def change
    drop_table :attendings
  end
end

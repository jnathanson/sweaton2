class AddCustomAddressToUser < ActiveRecord::Migration
  def change
    add_column :users, :home_address, :string
    add_column :users, :home_postcode, :string
  end
end

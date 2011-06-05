class AddLatLngToStores < ActiveRecord::Migration
  def self.up
    add_column :stores, :lat, :float
    add_column :stores, :lng, :float
  end

  def self.down
    remove_column :stores, :lng
    remove_column :stores, :lat
  end
end

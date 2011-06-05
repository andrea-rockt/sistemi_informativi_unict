class CreateStores < ActiveRecord::Migration
  def self.up
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :country
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps

      t.timestamps
    end
  end

  def self.down
    drop_table :stores
  end
end

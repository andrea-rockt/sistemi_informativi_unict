class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :model
      t.integer :price
      t.integer :quantity
      t.string :size
      t.integer :year

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end

class ChangeQuantityTypeInProducts < ActiveRecord::Migration
  def self.up
    change_table :products do |t|
      t.change :quantity, :string  
    end
  end

  def self.down
    change_table :products do |t|
        t.change :quantity,:string
    end  
  end
end

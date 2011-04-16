class AddPersonalDataColumnsToUser < ActiveRecord::Migration
  def self.up
  	change_table :users do |t|
  		 t.string :name, :null => false, :default => "name"
  		 t.string :surname, :null =>false, :default => "surname"
  		 t.string :address, :null =>false, :default => "address"
  		 t.string :city, :null =>false,  :default => "city"
  		 t.string :country, :null =>false, :default => "country"
  		 t.integer :height 
  	end
  end

  def self.down
  		[:name,:surname,:address,:city,:country,:height].each do |c|
  			remove_column :users, c
  		end
  end
end

class AddIsAdminToUsers < ActiveRecord::Migration
  def self.up
  	change_table :users do |t|
  		 t.boolean :is_admin, :null => false,:default => false 
  	end
  end

  def self.down
  	remove_column :is_admin
  end
end

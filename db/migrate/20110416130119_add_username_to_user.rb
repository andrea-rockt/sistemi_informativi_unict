class AddUsernameToUser < ActiveRecord::Migration
  def self.up
  	change_table :users do |t|
  		t.string :user_name, :null => false, :default => "username"
  	end
  end

  def self.down
  	remove_column :users , :user_name
  end
end

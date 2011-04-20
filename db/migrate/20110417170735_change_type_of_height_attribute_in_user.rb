class ChangeTypeOfHeightAttributeInUser < ActiveRecord::Migration
  def self.up
  	change_table :users do |t|
  		t.change :height, :float	
  	end
  end

  def self.down
  	  	t.change :height, :integer	
  end
end

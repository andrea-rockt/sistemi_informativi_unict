class DropDefaultsFromUserTable < ActiveRecord::Migration
  def self.up
		[:name,:surname,:address,:city,:country,:user_name].each do |t|
			  change_column :users, t, :string, :null => false, :default => ""
			  change_column_default(:users, t, nil)
		end  		
  end

  def self.down
  		[:name,:surname,:address,:city,:country,:user_name].each do |t|
			  change_column :users, t, :string, :null => false, :default => t.to_s
			  change_column_default(:users, t, nil)
		end  
  end
end

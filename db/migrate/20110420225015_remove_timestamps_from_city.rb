class RemoveTimestampsFromCity < ActiveRecord::Migration
  def self.up
	change_table :cities do |t|
		t.remove :created_at
		t.remove :updated_at
	end
  end

  def self.down
	change_table :cities do |t|
		t.timestamps
	end 
  end
end

class Changeinttofloatrate < ActiveRecord::Migration[6.1]
  def change
  	remove_column :listitems, :rate
  	add_column :listitems, :rate, :float
  end
end

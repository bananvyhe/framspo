class Listitemaddcol < ActiveRecord::Migration[6.1]
  def change
  	remove_column :listitems, :desc
  	add_column :listitems, :desc, :string
  	add_column :listitems, :item, :string
  	add_index :listitems, :item, unique: true
  end
end

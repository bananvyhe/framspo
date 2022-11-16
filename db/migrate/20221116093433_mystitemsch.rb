class Mystitemsch < ActiveRecord::Migration[6.1]
  def change
  	remove_reference :my_items, :listitems, foreign_key: true
  	 remove_column :my_items, :loa
  	 add_reference :my_items, :listitem, foreign_key: true
  end
end

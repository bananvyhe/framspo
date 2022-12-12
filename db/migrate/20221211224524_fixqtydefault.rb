class Fixqtydefault < ActiveRecord::Migration[6.1]
  def change
  	remove_column :my_items, :qty
  	add_column :my_items, :qty, :bigint, :default => 0
  end
end

class Changemyitemstable < ActiveRecord::Migration[6.1]
  def change
    remove_column :my_items, :title
    remove_column :my_items, :qty
    remove_column :my_items, :position
    remove_column :my_items, :desc
    add_reference :my_items, :listitems, foreign_key: true
  end
end

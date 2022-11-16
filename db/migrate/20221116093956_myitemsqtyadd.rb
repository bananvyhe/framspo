class Myitemsqtyadd < ActiveRecord::Migration[6.1]
  def change
  	add_column :my_items, :qty, :integer
  end
end

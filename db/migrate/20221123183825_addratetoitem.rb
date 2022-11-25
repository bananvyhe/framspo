class Addratetoitem < ActiveRecord::Migration[6.1]
  def change
  	add_column :listitems, :rate, :integer
  end
end

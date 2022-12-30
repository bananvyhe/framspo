class Changeposcol < ActiveRecord::Migration[6.1]
  def change
  	remove_column :my_items, :position
		add_column :my_items, :position, :integer
    MyItem.order(:updated_at).each.with_index(1) do |item, index|
			item.update_column :position, index
		end
  end
end

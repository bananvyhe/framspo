class AddPositionToMyItem < ActiveRecord::Migration[6.1]
  def change
    add_column :my_items, :position, :integer
  end
end

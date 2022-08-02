class AddLoaToMyItems < ActiveRecord::Migration[6.1]
  def change
    add_column :my_items, :loa, :integer
  end
end

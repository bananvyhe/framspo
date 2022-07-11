class AddIndexToNews < ActiveRecord::Migration[6.1]
  def change
  	remove_column :news, :link
    add_column :news, :link, :string
    add_index :news, :link, unique: true
  end
end

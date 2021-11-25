class AddColumnToNews < ActiveRecord::Migration[6.1]
  def change
    add_column :news, :biglink, :string
    add_column :news, :fullarticle, :string
  end
end

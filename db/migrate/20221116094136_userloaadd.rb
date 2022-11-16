class Userloaadd < ActiveRecord::Migration[6.1]
  def change
  	add_column :users, :loa, :integer
  end
end

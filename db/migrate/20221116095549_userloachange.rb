class Userloachange < ActiveRecord::Migration[6.1]
  def change
  	remove_column :users, :loa
  	add_column :users, :loa, :integer, :default => 0
  end
end

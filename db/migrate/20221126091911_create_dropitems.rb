class CreateDropitems < ActiveRecord::Migration[6.1]
  def change
    create_table :dropitems do |t|
    	t.belongs_to :mob
    	t.belongs_to :listitem
      t.timestamps
    end
  end
end

class Listitems < ActiveRecord::Migration[6.1]
  def change
    create_table :listitems do |t|
      t.string :title,index: { unique: true }
      t.integer :desc

      t.timestamps
    end
  end
end

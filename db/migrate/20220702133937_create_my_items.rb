class CreateMyItems < ActiveRecord::Migration[6.1]
  def change
    create_table :my_items do |t|
      t.string :title,index: { unique: true }
      t.integer :qty
      t.integer :position
      t.string :desc
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

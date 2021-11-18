class CreateNews < ActiveRecord::Migration[6.1]
  def change
    create_table :news do |t|
      t.string :pic
      t.string :link
      t.string :head
      t.string :date
      t.string :desc

      t.timestamps
    end
  end
end

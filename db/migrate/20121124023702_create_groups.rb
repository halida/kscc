class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.text :desc
      t.string :color
      t.integer :cheatsheet_id

      t.timestamps
    end
  end
end

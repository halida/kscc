class CreateShortcuts < ActiveRecord::Migration
  def change
    create_table :shortcuts do |t|
      t.string :key
      t.text :desc
      t.integer :group_id
      t.integer :cheatsheet_id

      t.timestamps
    end
  end
end

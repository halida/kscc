class CreateCheatsheets < ActiveRecord::Migration
  def change
    create_table :cheatsheets do |t|
      t.string :title
      t.string :background
      t.text :desc
      t.integer :layout, default: 0

      t.timestamps
    end
  end
end

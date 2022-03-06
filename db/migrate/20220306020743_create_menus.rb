class CreateMenus < ActiveRecord::Migration[6.1]
  def change
    create_table :menus do |t|
      t.integer :list_id, null: false
      t.integer :calender_id, null: false

      t.timestamps
    end
  end
end

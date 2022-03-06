class CreateCalenders < ActiveRecord::Migration[6.1]
  def change
    create_table :calenders do |t|
      t.integer :user_id, null: false
      t.integer :calender_date, null: false

      t.timestamps
    end
  end
end

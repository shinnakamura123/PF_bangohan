class CreateFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :foods do |t|
      t.string :food_name, null: false
      t.string :unit

      t.timestamps
    end
  end
end

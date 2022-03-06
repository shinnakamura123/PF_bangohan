class CreateFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :foods do |t|
      t.integer :recipe_id, null: false
      t.string :food_name, null: false
      t.string :unit, null: false

      t.timestamps
    end
  end
end
